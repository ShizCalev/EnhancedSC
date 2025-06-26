#include "logging.hpp"

#include "common.hpp"
#include <spdlog/sinks/base_sink.h>
#include <spdlog/spdlog.h>

std::shared_ptr<spdlog::logger> logger;
std::filesystem::path sLogFile = sFixName + ".log";
std::filesystem::path sFixPath;



// Spdlog sink (truncate on startup, single file)
template<typename Mutex>
class size_limited_sink : public spdlog::sinks::base_sink<Mutex>
{
public:
    explicit size_limited_sink(const std::string& filename, size_t max_size)
        : _filename(filename), _max_size(max_size)
    {
        truncate_log_file();

        _file.open(_filename, std::ios::app);
        if (!_file.is_open())
        {
            throw spdlog::spdlog_ex("Failed to open log file " + filename);
        }
    }

protected:
    void sink_it_(const spdlog::details::log_msg& msg) override
    {
        if (std::filesystem::exists(_filename) && std::filesystem::file_size(_filename) >= _max_size)
        {
            return;
        }

        spdlog::memory_buf_t formatted;
        this->formatter_->format(msg, formatted);

        _file.write(formatted.data(), formatted.size());
        _file.flush();
    }

    void flush_() override
    {
        _file.flush();
    }

private:
    std::ofstream _file;
    std::string _filename;
    size_t _max_size;

    void truncate_log_file()
    {
        if (std::filesystem::exists(_filename))
        {
            std::ofstream ofs(_filename, std::ofstream::out | std::ofstream::trunc);
            ofs.close();
        }
    }
};


void Logging::Initialize()
{
    // Get game name and exe path
    WCHAR exePath[_MAX_PATH] = { 0 };
    GetModuleFileNameW(baseModule, exePath, MAX_PATH);
    sExePath = exePath;
    sExeName = sExePath.filename().string();
    sExePath = sExePath.remove_filename();

    // spdlog initialisation
    {
        try
        {
            bool logDirExists = std::filesystem::is_directory(sExePath / "logs");
            if (!logDirExists)
            {
                std::filesystem::create_directory(sExePath / "logs"); //create a "logs" subdirectory in the game folder to keep the main directory tidy.
            }
            // Create 10MB truncated logger
            logger = std::make_shared<spdlog::logger>(sLogFile.string(), std::make_shared<size_limited_sink<std::mutex>>((sExePath / "logs" / sLogFile).string(), 10 * 1024 * 1024));
            spdlog::set_default_logger(logger);

            spdlog::flush_on(spdlog::level::debug);
            spdlog::set_pattern("[%Y-%m-%d %H:%M:%S.%e] [%l] %v");
            spdlog::info("---------- Logging initialization started ----------");
            if (!logDirExists)
            {
                spdlog::info("New log subdirectory created.");
            }
            spdlog::info("{} v{} loaded.", sFixName, VERSION_STRING);
            spdlog::info("ASI plugin location: {}", (sExePath / sFixPath / (sFixName + ".asi")).string());
            spdlog::info("----------");
            spdlog::info("Log file: {}", (sExePath / "logs" / sLogFile).string());
            spdlog::info("----------");

            // Log module details
            spdlog::info("Module Name: {0:s}", sExeName.c_str());
            spdlog::info("Module Path: {0:s}", sExePath.string());
            spdlog::info("Module Address: 0x{0:x}", (uintptr_t)baseModule);
            spdlog::info("Module Version: {}", Memory::GetModuleVersion(baseModule));
        }
        catch (const spdlog::spdlog_ex& ex)
        {
            AllocConsole();
            FILE* dummy;
            freopen_s(&dummy, "CONOUT$", "w", stdout);
            std::cout << "Log initialisation failed: " << ex.what() << std::endl;
            return FreeLibraryAndExitThread(baseModule, 1);
        }
    }
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::high_resolution_clock::now() - g_Logging.initStartTime).count(); \
        spdlog::info("---------- Logging loaded in: {} ms ----------", duration);
}

bool IsSteamOS()
{
    // Check for Proton/Steam Deck environment variables
    return std::getenv("STEAM_COMPAT_CLIENT_INSTALL_PATH") ||
        std::getenv("STEAM_COMPAT_DATA_PATH") ||
        std::getenv("XDG_SESSION_TYPE"); // XDG_SESSION_TYPE is often set on Linux
}

std::string GetSteamOSVersion()
{
    std::ifstream os_release("/etc/os-release");
    std::string line;
    while (std::getline(os_release, line))
    {
        if (line.find("PRETTY_NAME=") == 0)
        {
            // Remove quotes if present
            size_t first_quote = line.find('"');
            size_t last_quote = line.rfind('"');
            if (first_quote != std::string::npos && last_quote != std::string::npos && last_quote > first_quote)
            {
                return line.substr(first_quote + 1, last_quote - first_quote - 1);
            }
            return line.substr(13); // fallback
        }
    }
    return "";
}

///Prints CPU, GPU, and RAM info to the log to expedite common troubleshooting.
void Logging::LogSysInfo()
{
#ifndef _WIN32
    spdlog::info("System Details - Steam Deck/Linux");
    return;
#endif


    std::array<int, 4> integerBuffer = {};
    constexpr size_t sizeofIntegerBuffer = sizeof(int) * integerBuffer.size();
    std::array<char, 64> charBuffer = {};
    std::array<std::uint32_t, 3> functionIds = {
        0x8000'0002, // Manufacturer  
        0x8000'0003, // Model 
        0x8000'0004  // Clock-speed
    };

    std::string cpu;
    for (int id : functionIds)
    {
        __cpuid(integerBuffer.data(), id);
        std::memcpy(charBuffer.data(), integerBuffer.data(), sizeofIntegerBuffer);
        cpu += std::string(charBuffer.data());
    }

    spdlog::info("System Details - CPU: {}", cpu);

    std::string deviceString;
    for (int i = 0; ; i++)
    {
        DISPLAY_DEVICE dd = { sizeof(dd), 0 };
        BOOL f = EnumDisplayDevices(NULL, i, &dd, EDD_GET_DEVICE_INTERFACE_NAME);
        if (!f)
        {
            break; //that's all, folks.
        }
        char deviceStringBuffer[128];
        WideCharToMultiByte(CP_UTF8, 0, dd.DeviceString, -1, deviceStringBuffer, sizeof(deviceStringBuffer), NULL, NULL);
        if (deviceString == deviceStringBuffer) //each monitor reports what gpu is driving it, lets just double check in case we're looking at a laptop with mixed usage.
        {
            continue;
        }
        deviceString = deviceStringBuffer;
        spdlog::info("System Details - GPU: {}", deviceString);
    }

    MEMORYSTATUSEX status;
    status.dwLength = sizeof(status);
    GlobalMemoryStatusEx(&status);
    double totalMemory = status.ullTotalPhys / 1024 / 1024;    ///Total physical RAM in MB.
    spdlog::info("System Details - RAM: {} GB ({} MB)", ceil((totalMemory / 1024) * 100) / 100, totalMemory);


    std::string os;

    if (IsSteamOS())
    {
        os = GetSteamOSVersion();
    }
    else
    {
        HKEY key;
        LSTATUS versionResult = RegOpenKeyExA(
            HKEY_LOCAL_MACHINE,
            "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion",
            0, KEY_READ | KEY_WOW64_64KEY, &key
        );

        if (versionResult == ERROR_SUCCESS)
        {
            char buffer[256]; DWORD size = sizeof(buffer);
            LSTATUS nameResult = RegQueryValueExA(
                key, "ProductName",
                nullptr, nullptr,
                reinterpret_cast<LPBYTE>(buffer), &size
            );
            if (nameResult == ERROR_SUCCESS)
            {
                os = buffer;
            }
        }

        RegCloseKey(key);

        HMODULE ntdll = GetModuleHandleA("ntdll.dll");
        while (ntdll)
        {
            typedef LONG(WINAPI* RtlGetVersion_t)(PRTL_OSVERSIONINFOW);
            RtlGetVersion_t RtlGetVersion =
                reinterpret_cast<RtlGetVersion_t>(GetProcAddress(ntdll, "RtlGetVersion"));
            if (!RtlGetVersion) break;

            RTL_OSVERSIONINFOW info = {};
            info.dwOSVersionInfoSize = sizeof(RTL_OSVERSIONINFOW);

            if (RtlGetVersion(&info) != 0) break;
            os += " (build " + std::to_string(info.dwBuildNumber) + ")";

            if (info.dwBuildNumber < 22000) break;
            std::size_t pos = os.find("Windows 10");

            if (pos == std::string::npos) break;
            os.replace(pos, 10, "Windows 11");
            break;
        }
    }
    if (!os.empty()) spdlog::info("System Details - OS:  {}", os);

}