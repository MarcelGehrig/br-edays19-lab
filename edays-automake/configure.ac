AC_PREREQ([2.69])
AC_INIT([hello_automake], [1.0], [michael.schenk@noser.com])
AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE

# Checks for programs.
AC_PROG_CC_C99
AC_PROG_CPP

# Use the C language and compiler for the following checks
AC_LANG([C])

# Checks for libraries.
dnl checking libcurl
PKG_CHECK_MODULES(CURL, [libcurl],
		  [AC_DEFINE([HAVE_LIBCURL], [1], [Using Libcurl ])],
		  AC_MSG_WARN([libcurl not found. Not using web interaction.]))

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([stdio.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_SIZE_T

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT

