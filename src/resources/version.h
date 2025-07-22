// ReSharper disable CppClangTidyModernizeMacroToEnum
#pragma once

// Core name & version
#define FIX_NAME "EnhancedSC"
#define PRIMARY_REPO_URL "https://github.com/Joshhhuaaa/EnhancedSC"
//#define FALLBACK_REPO_URL "https://codeberg.org/Joshhhuaaa/EnhancedSC" //doesn't currently exist, but can be used in the future if needed

#define VERSION_MAJOR     1
#define VERSION_MINOR     2
#define VERSION_PATCH     1

#define STRINGIFY_HELPER(x) #x
#define STRINGIFY(x) STRINGIFY_HELPER(x)
#define VERSION_STRING STRINGIFY(VERSION_MAJOR) "." STRINGIFY(VERSION_MINOR) "." STRINGIFY(VERSION_PATCH)

// Metadata
#define COMPANY_NAME      "ShizCalev/Afevis & Contributors"
#define PRODUCT_NAME      FIX_NAME
#define FILE_DESCRIPTION  FIX_NAME " ASI Plugin"
#define INTERNAL_NAME     FIX_NAME ".asi"
#define ORIGINAL_FILENAME FIX_NAME ".asi"
#define PRODUCT_VERSION   VERSION_STRING
#define FILE_VERSION      VERSION_STRING
#define LEGAL_COPYRIGHT   "(C) ShizCalev/Afevis & Contributors. Licensed under the MIT License."
#define LEGAL_TRADEMARKS  ""
#define COMMENTS          ""
