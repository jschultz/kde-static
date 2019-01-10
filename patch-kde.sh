echo ./source/kdesupport/phonon/phonon
git -C ./source/kdesupport/phonon/phonon checkout .
patch -p1 -d ./source/kdesupport/phonon/phonon <<'EOF'
diff --git a/cmake/PhononMacros.cmake b/cmake/PhononMacros.cmake
index f829a486..c7032d92 100644
--- a/cmake/PhononMacros.cmake
+++ b/cmake/PhononMacros.cmake
@@ -24,13 +24,13 @@ endmacro(phonon_add_executable _target)
 
 macro(phonon_add_declarative_plugin _target)
     set(_srcs ${ARGN})
-    add_library(${_target} MODULE ${_global_add_executable_param} ${_srcs})
+    add_library(${_target} STATIC ${_global_add_executable_param} ${_srcs})
 endmacro(phonon_add_declarative_plugin _target)
 
 macro(phonon_add_designer_plugin _target _qrc_file)
     set(_srcs ${ARGN})
     qt5_add_resources(_srcs ${_qrc_file})
-    add_library(${_target} MODULE ${_global_add_executable_param} ${_srcs})
+    add_library(${_target} STATIC ${_global_add_executable_param} ${_srcs})
 endmacro(phonon_add_designer_plugin)
 
 macro (PHONON_UPDATE_ICONCACHE)
diff --git a/phonon/CMakeLists.txt b/phonon/CMakeLists.txt
index f9ae09e5..edebc6a6 100644
--- a/phonon/CMakeLists.txt
+++ b/phonon/CMakeLists.txt
@@ -136,7 +136,7 @@ endif (PHONON_NO_PLATFORMPLUGIN)
 add_definitions(-DPHONON_LIBRARY_PATH="${CMAKE_INSTALL_PREFIX}/${PLUGIN_INSTALL_DIR}/plugins")
 add_definitions(-DPHONON_BACKEND_DIR_SUFFIX="/${PHONON_LIB_SONAME}_backend/")
 
-add_library(${PHONON_LIB_SONAME} SHARED ${phonon_LIB_SRCS})
+add_library(${PHONON_LIB_SONAME} ${phonon_LIB_SRCS})
 qt5_use_modules(${PHONON_LIB_SONAME} Core Widgets)
 
 if(QT_QTDBUS_FOUND AND NOT PHONON_NO_DBUS)
diff --git a/phonon/experimental/CMakeLists.txt b/phonon/experimental/CMakeLists.txt
index e44cb7ac..b6e9c966 100644
--- a/phonon/experimental/CMakeLists.txt
+++ b/phonon/experimental/CMakeLists.txt
@@ -19,7 +19,7 @@ set(phononexperimental_LIB_SRCS
     ../abstractaudiooutput_p.cpp
     ../abstractvideooutput_p.cpp
    )
-add_library(${PHONON_LIB_SONAME}experimental SHARED ${phononexperimental_LIB_SRCS})
+add_library(${PHONON_LIB_SONAME}experimental ${phononexperimental_LIB_SRCS})
 qt5_use_modules(${PHONON_LIB_SONAME}experimental Core Widgets)
 target_link_libraries(${PHONON_LIB_SONAME}experimental ${PHONON_LIBS})
 set_target_properties(${PHONON_LIB_SONAME}experimental PROPERTIES
diff --git a/qt_phonon.pri b/qt_phonon.pri
index 9936e8de..daf824f8 100644
--- a/qt_phonon.pri
+++ b/qt_phonon.pri
@@ -5,4 +5,4 @@
 # Consequently, we have to do some stunts to get values out of the cache.
 !exists($$_QMAKE_CACHE_)| \
    !contains($$list($$fromfile($$_QMAKE_CACHE_, CONFIG)), QTDIR_build): \
-    QT_CONFIG += @PHONON_LIB_SONAME@
+    QT_CONFIG += phonon
EOF
echo ./source/kdesupport/polkit-qt-1
git -C ./source/kdesupport/polkit-qt-1 checkout .
patch -p1 -d ./source/kdesupport/polkit-qt-1 <<'EOF'
diff --git a/agent/CMakeLists.txt b/agent/CMakeLists.txt
index 51cb1d5..dfc338a 100644
--- a/agent/CMakeLists.txt
+++ b/agent/CMakeLists.txt
@@ -4,7 +4,7 @@ set(polkit_qt_agent_SRCS
     listeneradapter.cpp
     polkitqtlistener.cpp
 )
-add_library(${POLKITQT-1_AGENT_PCNAME} SHARED ${polkit_qt_agent_SRCS})
+add_library(${POLKITQT-1_AGENT_PCNAME} ${polkit_qt_agent_SRCS})
 
 add_library(${POLKITQT-1_CAMEL_NAME}::Agent ALIAS ${POLKITQT-1_AGENT_PCNAME})
 
diff --git a/core/CMakeLists.txt b/core/CMakeLists.txt
index 9da20d7..d662897 100644
--- a/core/CMakeLists.txt
+++ b/core/CMakeLists.txt
@@ -7,7 +7,7 @@ set(polkit_qt_core_SRCS
     polkitqt1-actiondescription.cpp
 )
 
-add_library(${POLKITQT-1_CORE_PCNAME} SHARED ${polkit_qt_core_SRCS})
+add_library(${POLKITQT-1_CORE_PCNAME} ${polkit_qt_core_SRCS})
 
 add_library(${POLKITQT-1_CAMEL_NAME}::Core ALIAS ${POLKITQT-1_CORE_PCNAME})
 
diff --git a/gui/CMakeLists.txt b/gui/CMakeLists.txt
index 8d1d537..f56bed0 100644
--- a/gui/CMakeLists.txt
+++ b/gui/CMakeLists.txt
@@ -4,7 +4,7 @@ set(polkit_qt_gui_SRCS
     polkitqt1-gui-actionbuttons.cpp
 )
 
-add_library(${POLKITQT-1_GUI_PCNAME} SHARED ${polkit_qt_gui_SRCS})
+add_library(${POLKITQT-1_GUI_PCNAME} ${polkit_qt_gui_SRCS})
 
 add_library(${POLKITQT-1_CAMEL_NAME}::Gui ALIAS ${POLKITQT-1_GUI_PCNAME})
 
EOF
echo ./source/kde/kdegraphics/libs/libkexiv2
git -C ./source/kde/kdegraphics/libs/libkexiv2 checkout .
patch -p1 -d ./source/kde/kdegraphics/libs/libkexiv2 <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 2b2df03..ba512ee 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -42,7 +42,7 @@ ecm_generate_headers(kexiv2_CamelCase_HEADERS
                      REQUIRED_HEADERS kexiv2_HEADERS
 )
 
-add_library(KF5KExiv2 SHARED ${kexiv2_LIB_SRCS})
+add_library(KF5KExiv2 ${kexiv2_LIB_SRCS})
 add_library(KF5::KExiv2 ALIAS KF5KExiv2)
 
 generate_export_header(KF5KExiv2 BASE_NAME libkexiv2 EXPORT_MACRO_NAME LIBKEXIV2_EXPORT)
EOF
echo ./source/kde/kdegraphics/kdegraphics-mobipocket
git -C ./source/kde/kdegraphics/kdegraphics-mobipocket checkout .
patch -p1 -d ./source/kde/kdegraphics/kdegraphics-mobipocket <<'EOF'
diff --git a/lib/CMakeLists.txt b/lib/CMakeLists.txt
index bfa258b..101a335 100644
--- a/lib/CMakeLists.txt
+++ b/lib/CMakeLists.txt
@@ -5,7 +5,7 @@ set (QMOBIPOCKET_SRCS
     qfilestream.cpp
 )
 
-add_library(qmobipocket SHARED ${QMOBIPOCKET_SRCS})
+add_library(qmobipocket ${QMOBIPOCKET_SRCS})
 generate_export_header(qmobipocket)
 
 target_link_libraries (qmobipocket
diff --git a/thumbnailers/CMakeLists.txt b/thumbnailers/CMakeLists.txt
index e9ff6ca..929224b 100644
--- a/thumbnailers/CMakeLists.txt
+++ b/thumbnailers/CMakeLists.txt
@@ -13,7 +13,7 @@ find_package(KF5 REQUIRED
     KIO
     )
 
-add_library(mobithumbnail MODULE ${mobithumbnail_SRCS})
+add_library(mobithumbnail STATIC ${mobithumbnail_SRCS})
 target_link_libraries(mobithumbnail KF5::KIOCore KF5::KIOWidgets Qt5::Gui qmobipocket)
 install(TARGETS mobithumbnail DESTINATION ${PLUGIN_INSTALL_DIR})
 
EOF
echo ./source/kde/kdegraphics/okular
git -C ./source/kde/kdegraphics/okular checkout .
patch -p1 -d ./source/kde/kdegraphics/okular <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9584e4994..6691d55b6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -3,7 +3,7 @@ cmake_minimum_required(VERSION 3.0)
 # KDE Application Version, managed by release script
 set (KDE_APPLICATIONS_VERSION_MAJOR "18")
 set (KDE_APPLICATIONS_VERSION_MINOR "12")
-set (KDE_APPLICATIONS_VERSION_MICRO "1")
+set (KDE_APPLICATIONS_VERSION_MICRO "0")
 set (KDE_APPLICATIONS_VERSION "${KDE_APPLICATIONS_VERSION_MAJOR}.${KDE_APPLICATIONS_VERSION_MINOR}.${KDE_APPLICATIONS_VERSION_MICRO}")
 
 project(okular VERSION 1.6.${KDE_APPLICATIONS_VERSION_MICRO})
@@ -33,6 +33,7 @@ ecm_setup_version(${PROJECT_VERSION}
                   PACKAGE_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/Okular5ConfigVersion.cmake")
 
 find_package(Qt5 ${QT_REQUIRED_VERSION} CONFIG REQUIRED COMPONENTS Core DBus Test Widgets PrintSupport Svg Qml Quick)
+find_package(Qt5 ${QT_REQUIRED_VERSION} CONFIG REQUIRED COMPONENTS Concurrent X11Extras)
 find_package(Qt5 ${QT_REQUIRED_VERSION} OPTIONAL_COMPONENTS TextToSpeech)
 if (NOT Qt5TextToSpeech_FOUND)
     message(STATUS "Qt5TextToSpeech not found, speech features will be disabled")
@@ -71,6 +72,7 @@ find_package(KF5 ${KF5_REQUIRED_VERSION} REQUIRED COMPONENTS
     JS
     Wallet
 )
+find_package(KF5 ${KF5_REQUIRED_VERSION} REQUIRED COMPONENTS DBusAddons GuiAddons Attica GlobalAccel)
 
 if(KF5Wallet_FOUND)
     add_definitions(-DWITH_KWALLET=1)
@@ -96,7 +98,7 @@ set_package_properties(KF5Kirigami2 PROPERTIES
     TYPE RUNTIME
 )
 find_package(Phonon4Qt5 CONFIG REQUIRED)
-find_package(KDEExperimentalPurpose)
+#find_package(KDEExperimentalPurpose)
 set_package_properties(KDEExperimentalPurpose PROPERTIES
     DESCRIPTION "A framework for services and actions integration"
     PURPOSE "Required for enabling the share menu in Okular"
@@ -142,8 +144,8 @@ if(BUILD_COVERAGE)
 endif()
 
 add_subdirectory( ui )
+add_subdirectory( generators )	# Static build needs generators to be processed before shell
 add_subdirectory( shell )
-add_subdirectory( generators )
 if(BUILD_TESTING)
    add_subdirectory( autotests )
    add_subdirectory( conf/autotests )
@@ -247,7 +249,9 @@ ki18n_wrap_ui(okularcore_SRCS
 
 kconfig_add_kcfg_files(okularcore_SRCS conf/settings_core.kcfgc)
 
-add_library(okularcore SHARED ${okularcore_SRCS})
+file (READ "${CMAKE_BINARY_DIR}/generators_static_list.txt" generators_static)
+
+add_library(okularcore STATIC ${okularcore_SRCS})
 generate_export_header(okularcore BASE_NAME okularcore EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/core/okularcore_export.h")
 
 if (ANDROID)
@@ -282,6 +286,7 @@ PRIVATE
     Phonon::phonon4qt5
     ${MATH_LIB}
     ${ZLIB_LIBRARIES}
+    ${generators_static}
 PUBLIC  # these are included from the installed headers
     KF5::CoreAddons
     KF5::XmlGui
@@ -290,6 +295,7 @@ PUBLIC  # these are included from the installed headers
     Qt5::Widgets
 )
 
+target_link_libraries(okularcore PUBLIC ${generators_static})
 
 if (KF5Wallet_FOUND)
     target_link_libraries(okularcore PRIVATE KF5::Wallet)
@@ -313,7 +319,7 @@ endif()
 
 set_target_properties(okularcore PROPERTIES VERSION 9.0.0 SOVERSION 9 OUTPUT_NAME Okular5Core EXPORT_NAME Core)
 
-install(TARGETS okularcore EXPORT Okular5Targets ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
+install(TARGETS okularcore ${generators_static} EXPORT Okular5Targets ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
 install(FILES conf/okular.kcfg DESTINATION ${KDE_INSTALL_KCFGDIR})
 install(FILES conf/okular_core.kcfg DESTINATION ${KDE_INSTALL_KCFGDIR})
@@ -400,7 +406,7 @@ ki18n_wrap_ui(okularpart_SRCS
 
 kconfig_add_kcfg_files(okularpart_SRCS conf/settings.kcfgc)
 
-add_library(okularpart SHARED ${okularpart_SRCS})
+add_library(okularpart ${okularpart_SRCS})
 generate_export_header(okularpart BASE_NAME okularpart)
 
 target_link_libraries(okularpart okularcore
diff --git a/core/document.cpp b/core/document.cpp
index 3332c3a89..2146b76a7 100644
--- a/core/document.cpp
+++ b/core/document.cpp
@@ -28,6 +28,7 @@
 
 // qt/kde/system includes
 #include <QtAlgorithms>
+#include <QDebug>
 #include <QDir>
 #include <QFile>
 #include <QFileInfo>
@@ -45,6 +46,7 @@
 #include <QDesktopServices>
 #include <QPageSize>
 #include <QStandardPaths>
+#include <QJsonDocument>
 
 #include <kauthorized.h>
 #include <kconfigdialog.h>
@@ -100,6 +102,10 @@
 #include "malloc.h"
 #endif
 
+static QVector<KPluginMetaData> s_availableGenerators;
+
+#include "generators_static.h"
+
 using namespace Okular;
 
 struct AllocatedPixmap
@@ -2215,6 +2221,12 @@ Document::Document( QWidget *widget )
     connect(d->m_undoStack, &QUndoStack::cleanChanged, this, &Document::undoHistoryCleanChanged);
 
     qRegisterMetaType<Okular::FontInfo>();
+
+    KPluginFactory *factory;
+    Generator * plugin;
+    KPluginMetaData service;
+#include "generators_static.i"
+
 }
 
 Document::~Document()
@@ -2281,7 +2293,8 @@ QVector<KPluginMetaData> DocumentPrivate::availableGenerators()
     static QVector<KPluginMetaData> result;
     if (result.isEmpty())
     {
-        result = KPluginLoader::findPlugins( QLatin1String ( "okular/generators" ) );
+//         result = KPluginLoader::findPlugins( QLatin1String ( "okular/generators" ) );
+        result = s_availableGenerators;
     }
     return result;
 }
diff --git a/core/document.h b/core/document.h
index 37cad1f1d..bb7365c43 100644
--- a/core/document.h
+++ b/core/document.h
@@ -28,6 +28,8 @@
 #include <QMimeType>
 #include <QUrl>
 
+// #include <KPluginFactory>
+
 class QPrintDialog;
 class KBookmark;
 class KConfigDialog;
@@ -35,6 +37,7 @@ class KPluginMetaData;
 class KXMLGUIClient;
 class DocumentItem;
 class QAbstractItemModel;
+class KPluginFactory;
 
 namespace Okular {
 
@@ -215,6 +218,7 @@ class OKULARCORE_EXPORT Document : public QObject
             OpenError,          //< The document failed to open
             OpenNeedsPassword   //< The document needs a password to be opened or the one provided is not the correct
         };
+        
 
         /**
          * Opens the document.
diff --git a/generators/CMakeLists.txt b/generators/CMakeLists.txt
index 6feec81b3..0613e05aa 100644
--- a/generators/CMakeLists.txt
+++ b/generators/CMakeLists.txt
@@ -5,6 +5,21 @@ function(okular_add_generator _target)
     INSTALL_NAMESPACE "okular/generators"
     SOURCES ${ARGN}
   )
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static_list.txt "${_target};")
+
+  file(GLOB HEADER "generator_*.h")
+  file(READ ${HEADER} header)
+  string(REGEX REPLACE "^.*class ([^ ]+Generator) .*$" "\\1" class ${header})
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.h "#include \"${HEADER}\"\n")
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.i "factory = new KPluginFactory();\n")
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.i "factory->registerPlugin<${class}>();\n")
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.i "plugin = factory->create<Okular::Generator>();\n")
+  file(READ "lib${_target}.json" json)
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.i "service = KPluginMetaData(QJsonDocument::fromJson(R\"(${json})\").object(), QString(""));\n")
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.i "GeneratorInfo info_${class}( plugin, service );\n")
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.i "s_availableGenerators.append( service );\n")
+  file(APPEND ${CMAKE_BINARY_DIR}/generators_static.i "d->m_loadedGenerators.insert( service.pluginId(), info_${class} );\n")
+
 endfunction()
 
 set(LIBSPECTRE_MINIMUM_VERSION "0.2")
@@ -132,7 +147,7 @@ add_subdirectory(ooo)
 
 add_subdirectory(fictionbook)
 
-add_subdirectory(comicbook)
+# add_subdirectory(comicbook)
 
 add_subdirectory(fax)
 
diff --git a/generators/chm/kio-msits/CMakeLists.txt b/generators/chm/kio-msits/CMakeLists.txt
index 36e670628..d8061b32b 100644
--- a/generators/chm/kio-msits/CMakeLists.txt
+++ b/generators/chm/kio-msits/CMakeLists.txt
@@ -10,7 +10,7 @@ include_directories(
 set(kio_msits_PART_SRCS msits.cpp kio_mits_debug.cpp)
 
 
-add_library(kio_msits MODULE ${kio_msits_PART_SRCS})
+add_library(kio_msits STATIC ${kio_msits_PART_SRCS})
 
 target_link_libraries(kio_msits  KF5::KIOCore Qt5::Core ${CHM_LIBRARY} Qt5::Network)
 
diff --git a/generators/plucker/generator_plucker.h b/generators/plucker/generator_plucker.h
index 2de7e1835..f4ee4aedc 100644
--- a/generators/plucker/generator_plucker.h
+++ b/generators/plucker/generator_plucker.h
@@ -15,7 +15,7 @@
 
 #include <QTextBlock>
 
-#include "qunpluck.h"
+#include "unpluck/qunpluck.h"
 
 class QTextDocument;
 
diff --git a/generators/poppler/generator_pdf.h b/generators/poppler/generator_pdf.h
index 4439a1144..46c41a71e 100644
--- a/generators/poppler/generator_pdf.h
+++ b/generators/poppler/generator_pdf.h
@@ -16,7 +16,7 @@
 
 //#include "synctex/synctex_parser.h"
 
-#include <poppler-qt5.h>
+#include </usr/include/poppler/qt5/poppler-qt5.h>
 
 
 #include <qbitarray.h>
diff --git a/mobile/components/CMakeLists.txt b/mobile/components/CMakeLists.txt
index f2529f78a..bd52e3770 100644
--- a/mobile/components/CMakeLists.txt
+++ b/mobile/components/CMakeLists.txt
@@ -22,7 +22,7 @@ set(okular_SRCS
 
 kconfig_add_kcfg_files(okular_SRCS ${CMAKE_SOURCE_DIR}/conf/settings.kcfgc )
 
-add_library(okularplugin SHARED ${okular_SRCS})
+add_library(okularplugin ${okular_SRCS})
 set_target_properties(okularplugin PROPERTIES COMPILE_DEFINITIONS "okularpart_EXPORTS")
 target_link_libraries(okularplugin
         Qt5::Quick
diff --git a/part.cpp b/part.cpp
index 2866d3737..0c940cf96 100644
--- a/part.cpp
+++ b/part.cpp
@@ -2034,7 +2034,7 @@ bool Part::slotAttemptReload( bool oneShot, const QUrl &newUrl )
     }
     else if ( !oneShot )
     {
-        // start watching the file again (since we dropped it on close) 
+        // start watching the file again (since we dropped it on close)
         setFileToWatch( localFilePath() );
         m_dirtyHandler->start( 750 );
     }
diff --git a/shell/CMakeLists.txt b/shell/CMakeLists.txt
index 628f74be1..e99b484c7 100644
--- a/shell/CMakeLists.txt
+++ b/shell/CMakeLists.txt
@@ -18,12 +18,13 @@ ecm_add_app_icon(okular_SRCS ICONS ${ICONS_SRCS})
 
 add_executable(okular ${okular_SRCS})
 
-target_link_libraries(okular KF5::Parts KF5::WindowSystem KF5::Crash)
+target_link_libraries(okular KF5::Parts KF5::WindowSystem KF5::Crash KF5::Archive okularcore okularpart)
 if(TARGET KF5::Activities)
     target_compile_definitions(okular PUBLIC -DWITH_KACTIVITIES=1)
 
 	target_link_libraries(okular KF5::Activities)
 endif()
+target_link_libraries(okular okularcore)
 
 install(TARGETS okular ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
 
diff --git a/shell/main.cpp b/shell/main.cpp
index 983690d08..3c6dd9ec6 100644
--- a/shell/main.cpp
+++ b/shell/main.cpp
@@ -28,6 +28,10 @@
 #include "okular_main.h"
 #include "shellutils.h"
 
+#include <QtPlugin>
+Q_IMPORT_PLUGIN(QXcbIntegrationPlugin)
+Q_IMPORT_PLUGIN(QSvgIconPlugin)
+
 int main(int argc, char** argv)
 {
     QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
diff --git a/shell/shell.cpp b/shell/shell.cpp
index d3f0b3e49..ea7503627 100644
--- a/shell/shell.cpp
+++ b/shell/shell.cpp
@@ -53,6 +53,8 @@
 #include <KActivities/ResourceInstance>
 #endif
 
+#include "../part.h"
+
 // local includes
 #include "kdocumentviewer.h"
 #include "../interfaces/viewerinterface.h"
@@ -79,19 +81,16 @@ Shell::Shell( const QString &serializedOptions )
   setXMLFile(QStringLiteral("shell.rc"));
   m_fileformatsscanned = false;
   m_showMenuBarAction = nullptr;
-  // this routine will find and load our Part.  it finds the Part by
-  // name which is a bad idea usually.. but it's alright in this
-  // case since our Part is made for this Shell
-  KPluginLoader loader(QStringLiteral("okularpart"));
-  m_partFactory = loader.factory();
+  m_partFactory = new KPluginFactory();
   if (!m_partFactory)
   {
     // if we couldn't find our Part, we exit since the Shell by
     // itself can't do anything useful
     m_isValid = false;
-    KMessageBox::error(this, i18n("Unable to find the Okular component: %1", loader.errorString()));
+    KMessageBox::error(this, i18n("Unable to find the Okular component"));
     return;
   }
+  m_partFactory->registerPlugin<Okular::Part>();
 
   // now that the Part plugin is loaded, create the part
   KParts::ReadWritePart* const firstPart = m_partFactory->create< KParts::ReadWritePart >( this );
diff --git a/ui/annotwindow.cpp b/ui/annotwindow.cpp
index d09a4f026..d65cda08f 100644
--- a/ui/annotwindow.cpp
+++ b/ui/annotwindow.cpp
@@ -40,13 +40,13 @@
 #include <core/utils.h>
 #include <KMessageBox>
 
-class CloseButton
+class CloseAnnotButton
   : public QPushButton
 {
     Q_OBJECT
 
 public:
-    CloseButton( QWidget * parent = Q_NULLPTR )
+    CloseAnnotButton( QWidget * parent = Q_NULLPTR )
       : QPushButton( parent )
     {
         setSizePolicy( QSizePolicy::Fixed, QSizePolicy::Fixed );
@@ -88,7 +88,7 @@ public:
         dateLabel->setFont( f );
         dateLabel->setCursor( Qt::SizeAllCursor );
         buttonlay->addWidget( dateLabel );
-        CloseButton * close = new CloseButton( this );
+        CloseAnnotButton * close = new CloseAnnotButton( this );
         connect( close, &QAbstractButton::clicked, parent, &QWidget::close );
         buttonlay->addWidget( close );
         // option button row
EOF
echo ./source/kde/kdenetwork/kaccounts-integration
git -C ./source/kde/kdenetwork/kaccounts-integration checkout .
patch -p1 -d ./source/kde/kdenetwork/kaccounts-integration <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 0d08576..7f84a1f 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -13,7 +13,7 @@ set(kaccounts_SRCS
 
 ki18n_wrap_ui(kaccounts_SRCS kcm.ui types.ui services.ui)
 
-add_library(kcm_kaccounts MODULE ${kaccounts_SRCS})
+add_library(kcm_kaccounts STATIC ${kaccounts_SRCS})
 kcoreaddons_desktop_to_json(kcm_kaccounts kcm_kaccounts.desktop)
 
 target_link_libraries(kcm_kaccounts
diff --git a/src/daemon/CMakeLists.txt b/src/daemon/CMakeLists.txt
index f037684..5271e39 100644
--- a/src/daemon/CMakeLists.txt
+++ b/src/daemon/CMakeLists.txt
@@ -4,7 +4,7 @@ set(accounts_daemon_SRCS
     daemon.cpp
 )
 
-add_library(kded_accounts MODULE
+add_library(kded_accounts STATIC
     ${accounts_daemon_SRCS}
 )
 kcoreaddons_desktop_to_json(kded_accounts accounts.desktop)
diff --git a/src/daemon/kio-webdav/CMakeLists.txt b/src/daemon/kio-webdav/CMakeLists.txt
index f5f5ad4..bf2685e 100644
--- a/src/daemon/kio-webdav/CMakeLists.txt
+++ b/src/daemon/kio-webdav/CMakeLists.txt
@@ -6,7 +6,7 @@ set(kio-webdav_SRCS
     createkioservice.cpp
     removekioservice.cpp)
 
-add_library(kaccounts_kio_webdav_plugin MODULE ${kio-webdav_SRCS})
+add_library(kaccounts_kio_webdav_plugin STATIC ${kio-webdav_SRCS})
 
 target_link_libraries(kaccounts_kio_webdav_plugin
     Qt5::Core
diff --git a/src/declarative/CMakeLists.txt b/src/declarative/CMakeLists.txt
index ab35afe..900c960 100644
--- a/src/declarative/CMakeLists.txt
+++ b/src/declarative/CMakeLists.txt
@@ -1,6 +1,6 @@
 include_directories(${CMAKE_CURRENT_BINARY_DIR}/.. ${CMAKE_CURRENT_SOURCE_DIR}/..)
 
-add_library(kaccountsdeclarativeplugin SHARED kaccountsdeclarativeplugin.cpp
+add_library(kaccountsdeclarativeplugin kaccountsdeclarativeplugin.cpp
                             ../jobs/createaccount.cpp
                             ../uipluginsmanager.cpp)
 
diff --git a/src/lib/CMakeLists.txt b/src/lib/CMakeLists.txt
index 01d0671..4c92a23 100644
--- a/src/lib/CMakeLists.txt
+++ b/src/lib/CMakeLists.txt
@@ -35,7 +35,7 @@ ecm_generate_headers(kaccountslib_HEADERS
   REQUIRED_HEADERS kaccountslib_HEADERS
 )
 
-add_library (kaccounts SHARED
+add_library (kaccounts
              ${kaccountslib_SRCS}
 )
 
EOF
echo ./source/frameworks/sonnet
git -C ./source/frameworks/sonnet checkout .
patch -p1 -d ./source/frameworks/sonnet <<'EOF'
diff --git a/src/plugins/aspell/CMakeLists.txt b/src/plugins/aspell/CMakeLists.txt
index a29aab4..a459a67 100644
--- a/src/plugins/aspell/CMakeLists.txt
+++ b/src/plugins/aspell/CMakeLists.txt
@@ -7,7 +7,7 @@ include_directories( ${ASPELL_INCLUDE_DIR})
 set(sonnet_aspell_PART_SRCS aspellclient.cpp aspelldict.cpp)
 ecm_qt_declare_logging_category(sonnet_aspell_PART_SRCS HEADER aspell_debug.h IDENTIFIER SONNET_LOG_ASPELL CATEGORY_NAME sonnet.plugins.aspell)
 
-add_library(sonnet_aspell MODULE ${sonnet_aspell_PART_SRCS})
+add_library(sonnet_aspell STATIC ${sonnet_aspell_PART_SRCS})
 
 target_link_libraries(sonnet_aspell PRIVATE KF5::SonnetCore ${ASPELL_LIBRARIES})
 
diff --git a/src/plugins/enchant/CMakeLists.txt b/src/plugins/enchant/CMakeLists.txt
index 72d6d65..3a94d76 100644
--- a/src/plugins/enchant/CMakeLists.txt
+++ b/src/plugins/enchant/CMakeLists.txt
@@ -6,7 +6,7 @@ include_directories( ${ENCHANT_INCLUDE_DIR} "${ENCHANT_INCLUDE_DIR}/.." )
 set(kspell_enchant_PART_SRCS enchantdict.cpp enchantclient.cpp )
 
 
-add_library(kspell_enchant MODULE ${kspell_enchant_PART_SRCS})
+add_library(kspell_enchant STATIC ${kspell_enchant_PART_SRCS})
 
 target_link_libraries(kspell_enchant PRIVATE KF5::SonnetCore ${ENCHANT_LIBRARIES})
 
diff --git a/src/plugins/hspell/CMakeLists.txt b/src/plugins/hspell/CMakeLists.txt
index c2dc2d4..30036c1 100644
--- a/src/plugins/hspell/CMakeLists.txt
+++ b/src/plugins/hspell/CMakeLists.txt
@@ -14,7 +14,7 @@ set(sonnet_hspell_PART_SRCS hspellclient.cpp hspelldict.cpp)
 
 ecm_qt_declare_logging_category(sonnet_hspell_PART_SRCS HEADER hspell_debug.h IDENTIFIER SONNET_LOG_HSPELL CATEGORY_NAME sonnet.plugins.hspell)
 
-add_library(sonnet_hspell MODULE ${sonnet_hspell_PART_SRCS})
+add_library(sonnet_hspell STATIC ${sonnet_hspell_PART_SRCS})
 
 target_link_libraries(sonnet_hspell PRIVATE KF5::SonnetCore ${HSPELL_LIBRARIES} ${ZLIB_LIBRARY})
 
diff --git a/src/plugins/hunspell/CMakeLists.txt b/src/plugins/hunspell/CMakeLists.txt
index 8fd9081..2e77728 100644
--- a/src/plugins/hunspell/CMakeLists.txt
+++ b/src/plugins/hunspell/CMakeLists.txt
@@ -13,7 +13,7 @@ message(STATUS "Using old hunspell API: ${USE_OLD_HUNSPELL_API}")
 
 configure_file(config-hunspell.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-hunspell.h)
 
-add_library(sonnet_hunspell MODULE ${sonnet_hunspell_PART_SRCS})
+add_library(sonnet_hunspell STATIC ${sonnet_hunspell_PART_SRCS})
 target_include_directories(sonnet_hunspell SYSTEM PUBLIC ${HUNSPELL_INCLUDE_DIRS})
 target_link_libraries(sonnet_hunspell PRIVATE KF5::SonnetCore ${HUNSPELL_LIBRARIES})
 target_compile_definitions(sonnet_hunspell PRIVATE DEFINITIONS SONNET_INSTALL_PREFIX="${CMAKE_INSTALL_PREFIX}")
diff --git a/src/plugins/nsspellchecker/CMakeLists.txt b/src/plugins/nsspellchecker/CMakeLists.txt
index f79f745..e8cfa8d 100644
--- a/src/plugins/nsspellchecker/CMakeLists.txt
+++ b/src/plugins/nsspellchecker/CMakeLists.txt
@@ -7,7 +7,7 @@ ecm_qt_declare_logging_category(sonnet_nsspellchecker_PART_SRCS
     IDENTIFIER SONNET_NSSPELLCHECKER
     CATEGORY_NAME sonnet.plugins.nsspellchecker)
 
-add_library(sonnet_nsspellchecker MODULE ${sonnet_nsspellchecker_PART_SRCS})
+add_library(sonnet_nsspellchecker STATIC ${sonnet_nsspellchecker_PART_SRCS})
 
 target_link_libraries(sonnet_nsspellchecker PRIVATE KF5::SonnetCore "-framework AppKit")
 
diff --git a/src/plugins/voikko/CMakeLists.txt b/src/plugins/voikko/CMakeLists.txt
index ca22424..10c8212 100644
--- a/src/plugins/voikko/CMakeLists.txt
+++ b/src/plugins/voikko/CMakeLists.txt
@@ -6,7 +6,7 @@ include_directories(${VOIKKO_INCLUDE_DIR})
 set(sonnet_voikko_PART_SRCS voikkoclient.cpp voikkodict.cpp)
 ecm_qt_declare_logging_category(sonnet_voikko_PART_SRCS HEADER voikkodebug.h IDENTIFIER SONNET_VOIKKO CATEGORY_NAME sonnet.plugins.voikko)
 
-add_library(sonnet_voikko MODULE ${sonnet_voikko_PART_SRCS})
+add_library(sonnet_voikko STATIC ${sonnet_voikko_PART_SRCS})
 
 target_link_libraries(sonnet_voikko PRIVATE KF5::SonnetCore ${VOIKKO_LIBRARIES})
 
EOF
echo ./source/frameworks/kactivities
git -C ./source/frameworks/kactivities checkout .
patch -p1 -d ./source/frameworks/kactivities <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index fd0bd15..e0403aa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -43,7 +43,7 @@ add_feature_info(QCH ${BUILD_QCH} "API documentation in QCH format (for e.g. Qt
 
 # Qt
 set (CMAKE_AUTOMOC ON)
-find_package (Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED COMPONENTS Core DBus)
+find_package (Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED COMPONENTS Core DBus X11Extras)
 
 # Basic includes
 include (CPack)
diff --git a/src/imports/CMakeLists.txt b/src/imports/CMakeLists.txt
index 2efda2b..4b32b3b 100644
--- a/src/imports/CMakeLists.txt
+++ b/src/imports/CMakeLists.txt
@@ -19,7 +19,7 @@ set (
    ${KACTIVITIES_CURRENT_ROOT_SOURCE_DIR}/src/utils/dbusfuture_p.cpp
    )
 
-add_library (kactivitiesextensionplugin SHARED ${kactivities_imports_LIB_SRCS})
+add_library (kactivitiesextensionplugin ${kactivities_imports_LIB_SRCS})
 
 target_link_libraries (
    kactivitiesextensionplugin
diff --git a/src/lib/CMakeLists.txt b/src/lib/CMakeLists.txt
index 11eaee4..f3c37cd 100644
--- a/src/lib/CMakeLists.txt
+++ b/src/lib/CMakeLists.txt
@@ -69,7 +69,7 @@ ecm_qt_declare_logging_category(KActivities_LIB_SRCS HEADER debug_p.h IDENTIFIER
 
 
 add_library (
-   KF5Activities SHARED
+   KF5Activities
    ${KActivities_LIB_SRCS}
    )
 add_library (KF5::Activities ALIAS KF5Activities)
EOF
echo ./source/frameworks/knewstuff
git -C ./source/frameworks/knewstuff checkout .
patch -p1 -d ./source/frameworks/knewstuff <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 0059d4c..5755561 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -16,7 +16,7 @@ include(KDECMakeSettings)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED COMPONENTS Widgets Xml)
+find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED COMPONENTS Widgets Xml Concurrent PrintSupport Svg TextToSpeech X11Extras)
 find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE COMPONENTS Qml Quick)
 
 find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
@@ -31,6 +31,11 @@ find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 include(GenerateExportHeader)
 include(ECMSetupVersion)
EOF
echo ./source/frameworks/kimageformats
git -C ./source/frameworks/kimageformats checkout .
patch -p1 -d ./source/frameworks/kimageformats <<'EOF'
diff --git a/src/imageformats/CMakeLists.txt b/src/imageformats/CMakeLists.txt
index 0dc9707..2e451fd 100644
--- a/src/imageformats/CMakeLists.txt
+++ b/src/imageformats/CMakeLists.txt
@@ -15,7 +15,7 @@ function(kimageformats_add_plugin plugin)
         message(FATAL_ERROR "JSON file doesn't exist: ${json}")
     endif()
 
-    add_library(${plugin} MODULE ${KIF_ADD_PLUGIN_SOURCES})
+    add_library(${plugin} STATIC ${KIF_ADD_PLUGIN_SOURCES})
     set_property(TARGET ${plugin} APPEND PROPERTY AUTOGEN_TARGET_DEPENDS ${json})
     set_target_properties(${plugin} PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/imageformats")
     target_link_libraries(${plugin} Qt5::Gui)
EOF
echo ./source/frameworks/krunner
git -C ./source/frameworks/krunner checkout .
patch -p1 -d ./source/frameworks/krunner <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 742ea5c..a42d8ee 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -36,7 +36,7 @@ ecm_setup_version(PROJECT
 # Dependencies
 set(REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Gui Widgets Quick)
+find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Gui Widgets Quick Sql Svg X11Extras PrintSupport TextToSpeech)
 
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
@@ -45,6 +45,20 @@ find_package(KF5KIO ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Plasma ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5ThreadWeaver ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Declarative ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Notifications ${KF5_DEP_VERSION} REQUIRED)
+
+find_package(Phonon4Qt5 4.6.60 REQUIRED)
+find_package(XCB COMPONENTS XCB)
 
 set(KRunner_AUTOMOC_MACRO_NAMES "K_EXPORT_PLASMA_RUNNER" "K_EXPORT_RUNNER_CONFIG")
 if(NOT CMAKE_VERSION VERSION_LESS "3.10.0")
diff --git a/src/declarative/CMakeLists.txt b/src/declarative/CMakeLists.txt
index 83837b0..0f0a792 100644
--- a/src/declarative/CMakeLists.txt
+++ b/src/declarative/CMakeLists.txt
@@ -6,7 +6,7 @@ set(runnermodel_SRCS
     )
 ecm_qt_declare_logging_category(runnermodel_SRCS HEADER krunner_debug.h IDENTIFIER KRUNNER CATEGORY_NAME org.kde.krunner)
 
-add_library(runnermodelplugin SHARED ${runnermodel_SRCS})
+add_library(runnermodelplugin ${runnermodel_SRCS})
 target_link_libraries(runnermodelplugin
         Qt5::Quick
         Qt5::Qml
diff --git a/templates/runner/src/CMakeLists.txt b/templates/runner/src/CMakeLists.txt
index b6fabfd..920e6b8 100644
--- a/templates/runner/src/CMakeLists.txt
+++ b/templates/runner/src/CMakeLists.txt
@@ -2,7 +2,7 @@ add_definitions(-DTRANSLATION_DOMAIN=\"plasma_runner_org.kde.%{APPNAMELC}\")
 
 set(%{APPNAMELC}_SRCS %{APPNAMELC}.cpp)
 
-add_library(krunner_%{APPNAMELC} MODULE ${%{APPNAMELC}_SRCS})
+add_library(krunner_%{APPNAMELC} STATIC ${%{APPNAMELC}_SRCS})
 target_link_libraries(krunner_%{APPNAMELC} KF5::Runner KF5::I18n)
 
 install(TARGETS krunner_%{APPNAMELC} DESTINATION ${KDE_INSTALL_PLUGINDIR})
EOF
echo ./source/frameworks/kitemmodels
git -C ./source/frameworks/kitemmodels checkout .
patch -p1 -d ./source/frameworks/kitemmodels <<'EOF'
diff --git a/autotests/proxymodeltestsuite/CMakeLists.txt b/autotests/proxymodeltestsuite/CMakeLists.txt
index cbb89aa..820b2dc 100644
--- a/autotests/proxymodeltestsuite/CMakeLists.txt
+++ b/autotests/proxymodeltestsuite/CMakeLists.txt
@@ -47,7 +47,7 @@ if (Grantlee_FOUND)
 endif()
 
 
-add_library(proxymodeltestsuite SHARED
+add_library(proxymodeltestsuite
   ${proxymodeltestsuite_SRCS}
   ${eventlogger_RCS_SRCS}
 )
EOF
echo ./source/frameworks/kxmlrpcclient
git -C ./source/frameworks/kxmlrpcclient checkout .
patch -p1 -d ./source/frameworks/kxmlrpcclient <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 329308acd..7fbe1124d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -36,8 +36,13 @@ ecm_setup_version(PROJECT VARIABLE_PREFIX KXMLRPCCLIENT
 )
 
 ########### Find packages ###########
+find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Concurrent X11Extras)
+
 find_package(KF5I18n ${KF5_DEP_VERSION} CONFIG REQUIRED)
 find_package(KF5KIO ${KF5_DEP_VERSION} CONFIG REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} CONFIG REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 
 if(BUILD_TESTING)
    add_definitions(-DBUILD_TESTING)
EOF
echo ./source/frameworks/ktextwidgets
git -C ./source/frameworks/ktextwidgets checkout .
patch -p1 -d ./source/frameworks/ktextwidgets <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index e233efc..f9bb220 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -31,7 +31,7 @@ ecm_setup_version(PROJECT
 # Dependencies
 set(REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus X11Extras Svg)
 
 find_package(Qt5 OPTIONAL_COMPONENTS TextToSpeech)
 if (NOT Qt5TextToSpeech_FOUND)
@@ -49,6 +49,10 @@ find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Sonnet ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5ItemViews ${KF5_DEP_VERSION} REQUIRED)
 
 option(BUILD_QCH "Build API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)" OFF)
 add_feature_info(QCH ${BUILD_QCH} "API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)")
EOF
echo ./source/frameworks/kinit
git -C ./source/frameworks/kinit checkout .
patch -p1 -d ./source/frameworks/kinit <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index ca6d149..bf12157 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -10,7 +10,7 @@ feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKA
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 "${REQUIRED_QT_VERSION}" CONFIG REQUIRED Core Gui DBus)
+find_package(Qt5 "${REQUIRED_QT_VERSION}" CONFIG REQUIRED Core Gui DBus X11Extras Concurrent Svg)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -54,6 +54,10 @@ find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DocTools ${KF5_DEP_VERSION})
+find_package(KF5DBusAddons ${KF5_DEP_VERSION})
+find_package(KF5IconThemes ${KF5_DEP_VERSION})
+find_package(KF5GuiAddons ${KF5_DEP_VERSION})
+find_package(KF5Archive ${KF5_DEP_VERSION})
 
 if (NOT WIN32)
 find_package(Libcap)
diff --git a/KF5InitMacros.cmake b/KF5InitMacros.cmake
index 834e2be..e5c57a7 100644
--- a/KF5InitMacros.cmake
+++ b/KF5InitMacros.cmake
@@ -33,7 +33,7 @@ function (KF5_ADD_KDEINIT_EXECUTABLE _target_NAME )
         add_library(kdeinit_${_target_NAME} STATIC ${_SRCS})
     else()
         # Use a shared library on UNIX so that kdeinit can dlopen() it
-        add_library(kdeinit_${_target_NAME} SHARED ${_SRCS})
+        add_library(kdeinit_${_target_NAME} ${_SRCS})
     endif()
     if (APPLE)
         set(_resourcefile ${MACOSX_BUNDLE_ICON_FILE})
EOF
echo ./source/frameworks/modemmanager-qt
git -C ./source/frameworks/modemmanager-qt checkout .
patch -p1 -d ./source/frameworks/modemmanager-qt <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 5e22a87..5207fe1 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -68,7 +68,7 @@ if (${MODEMMANAGER_VERSION} VERSION_EQUAL 1.6.0 OR ${MODEMMANAGER_VERSION} VERSI
         )
 endif()
 
-add_library(KF5ModemManagerQt SHARED ${ModemManagerQt_SRCS} ${DBUS_INTERFACES_FILES})
+add_library(KF5ModemManagerQt ${ModemManagerQt_SRCS} ${DBUS_INTERFACES_FILES})
 generate_export_header(KF5ModemManagerQt BASE_NAME ModemManagerQt)
 add_library(KF5::ModemManagerQt ALIAS KF5ModemManagerQt)
 
EOF
echo ./source/frameworks/kfilemetadata
git -C ./source/frameworks/kfilemetadata checkout .
patch -p1 -d ./source/frameworks/kfilemetadata <<'EOF'
diff --git a/src/extractors/CMakeLists.txt b/src/extractors/CMakeLists.txt
index 15399f7..7aee8a6 100644
--- a/src/extractors/CMakeLists.txt
+++ b/src/extractors/CMakeLists.txt
@@ -1,7 +1,7 @@
 
 
 if(Poppler_Qt5_FOUND)
-    add_library(kfilemetadata_popplerextractor MODULE popplerextractor.cpp)
+    add_library(kfilemetadata_popplerextractor STATIC popplerextractor.cpp)
 
     target_link_libraries(kfilemetadata_popplerextractor
         KF5::FileMetaData
@@ -16,7 +16,7 @@ if(Poppler_Qt5_FOUND)
 endif()
 
 if(TAGLIB_FOUND)
-    add_library(kfilemetadata_taglibextractor MODULE taglibextractor.cpp )
+       add_library(kfilemetadata_taglibextractor STATIC taglibextractor.cpp )
     target_include_directories(kfilemetadata_taglibextractor SYSTEM PRIVATE ${TAGLIB_INCLUDES})
     target_link_libraries( kfilemetadata_taglibextractor
         KF5::FileMetaData
@@ -30,7 +30,7 @@ if(TAGLIB_FOUND)
 endif()
 
 if(LibExiv2_FOUND)
-    add_library(kfilemetadata_exiv2extractor MODULE exiv2extractor.cpp)
+    add_library(kfilemetadata_exiv2extractor STATIC exiv2extractor.cpp)
     kde_target_enable_exceptions(kfilemetadata_exiv2extractor PRIVATE)
     target_link_libraries(kfilemetadata_exiv2extractor
         KF5::FileMetaData
@@ -45,7 +45,7 @@ if(LibExiv2_FOUND)
 endif()
 
 if(FFMPEG_FOUND)
-    add_library(kfilemetadata_ffmpegextractor MODULE ffmpegextractor.cpp)
+    add_library(kfilemetadata_ffmpegextractor STATIC ffmpegextractor.cpp)
     target_include_directories(kfilemetadata_ffmpegextractor SYSTEM PRIVATE ${AVCODEC_INCLUDE_DIRS} ${AVFORMAT_INCLUDE_DIRS} ${AVUTIL_INCLUDE_DIRS})
     target_link_libraries(kfilemetadata_ffmpegextractor
         KF5::FileMetaData
@@ -63,7 +63,7 @@ endif()
 
 
 if(EPUB_FOUND)
-    add_library(kfilemetadata_epubextractor MODULE epubextractor.cpp)
+    add_library(kfilemetadata_epubextractor STATIC epubextractor.cpp)
     target_include_directories(kfilemetadata_epubextractor SYSTEM PRIVATE ${EPUB_INCLUDE_DIR})
     target_link_libraries(kfilemetadata_epubextractor
         KF5::FileMetaData
@@ -80,7 +80,7 @@ endif()
 #
 # Plain Text
 #
-add_library(kfilemetadata_plaintextextractor MODULE plaintextextractor.cpp)
+add_library(kfilemetadata_plaintextextractor STATIC plaintextextractor.cpp)
 
 target_link_libraries( kfilemetadata_plaintextextractor
     KF5::FileMetaData
@@ -94,7 +94,7 @@ DESTINATION ${PLUGIN_INSTALL_DIR}/kf5/kfilemetadata)
 #
 # PO
 #
-add_library(kfilemetadata_poextractor MODULE poextractor.cpp)
+add_library(kfilemetadata_poextractor STATIC poextractor.cpp)
 target_link_libraries( kfilemetadata_poextractor
     KF5::FileMetaData
 )
@@ -107,7 +107,7 @@ DESTINATION ${PLUGIN_INSTALL_DIR}/kf5/kfilemetadata)
 #
 # XML
 #
-add_library(kfilemetadata_xmlextractor MODULE
+add_library(kfilemetadata_xmlextractor STATIC
    dublincoreextractor.cpp
    xmlextractor.cpp
    ../kfilemetadata_debug.cpp
@@ -127,7 +127,7 @@ install(
 #
 # Postscript DSC
 #
-add_library(kfilemetadata_postscriptdscextractor MODULE
+add_library(kfilemetadata_postscriptdscextractor STATIC
    postscriptdscextractor.cpp
    ../kfilemetadata_debug.cpp
 )
@@ -147,7 +147,7 @@ install(
 #
 
 if(KF5Archive_FOUND)
-    add_library(kfilemetadata_odfextractor MODULE odfextractor.cpp)
+    add_library(kfilemetadata_odfextractor STATIC odfextractor.cpp)
 
     target_link_libraries(kfilemetadata_odfextractor
         KF5::FileMetaData
@@ -167,7 +167,7 @@ endif()
 #
 
 if(KF5Archive_FOUND)
-    add_library(kfilemetadata_office2007extractor MODULE office2007extractor.cpp)
+    add_library(kfilemetadata_office2007extractor STATIC office2007extractor.cpp)
 
     target_link_libraries(kfilemetadata_office2007extractor
         KF5::FileMetaData
@@ -186,7 +186,7 @@ endif()
 # Office (binary formats)
 #
 
-add_library(kfilemetadata_officeextractor MODULE officeextractor.cpp)
+add_library(kfilemetadata_officeextractor STATIC officeextractor.cpp)
 
 target_link_libraries(kfilemetadata_officeextractor
     KF5::FileMetaData
@@ -201,7 +201,7 @@ DESTINATION ${PLUGIN_INSTALL_DIR}/kf5/kfilemetadata)
 # Mobipocket
 #
 if (QMOBIPOCKET_FOUND)
-    add_library(kfilemetadata_mobiextractor MODULE mobiextractor.cpp)
+    add_library(kfilemetadata_mobiextractor STATIC mobiextractor.cpp)
     target_include_directories(kfilemetadata_mobiextractor SYSTEM PRIVATE ${QMOBIPOCKET_INCLUDE_DIR})
     target_link_libraries(kfilemetadata_mobiextractor
         KF5::FileMetaData
diff --git a/src/writers/CMakeLists.txt b/src/writers/CMakeLists.txt
index 864dc51..11d80cf 100644
--- a/src/writers/CMakeLists.txt
+++ b/src/writers/CMakeLists.txt
@@ -1,5 +1,5 @@
 if(TAGLIB_FOUND)
-    add_library(kfilemetadata_taglibwriter MODULE taglibwriter.cpp)
+    add_library(kfilemetadata_taglibwriter STATIC taglibwriter.cpp)
     target_include_directories(kfilemetadata_taglibwriter SYSTEM PRIVATE ${TAGLIB_INCLUDES})
 
     target_link_libraries( kfilemetadata_taglibwriter
EOF
echo ./source/frameworks/khtml
git -C ./source/frameworks/khtml checkout .
patch -p1 -d ./source/frameworks/khtml <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d5fdf01..5e81e4a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -19,7 +19,7 @@ include(ECMQtDeclareLoggingCategory)
 
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 "${REQUIRED_QT_VERSION}" CONFIG REQUIRED Widgets Network DBus PrintSupport Xml)
+find_package(Qt5 "${REQUIRED_QT_VERSION}" CONFIG REQUIRED Widgets Network DBus PrintSupport Xml Concurrent Svg TextToSpeech)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -42,6 +42,10 @@ find_package(KF5Wallet ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 ecm_setup_version(PROJECT VARIABLE_PREFIX KHTML
                         VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/khtml_version.h"
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index a593599..2aa7a42 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -727,7 +727,7 @@ create_js_binding(html/HTMLVideoElement.idl)
 set(khtmlpart_PART_SRCS khtml_factory.cpp )
 
 
-add_library(khtmlpart MODULE ${khtmlpart_PART_SRCS})
+add_library(khtmlpart ${khtmlpart_PART_SRCS})
 
 target_link_libraries(khtmlpart KF5::KHtml KF5::XmlGui KF5::TextWidgets KF5::Parts KF5::I18n)
 
@@ -747,7 +747,7 @@ install(TARGETS khtmlpart  DESTINATION ${KDE_INSTALL_PLUGINDIR}/kf5/parts)
 
 # Note that khtmlimage.cpp is part of libkhtml because it uses internal objects (render tree and loader)
 # Only the entry point is separated into khtmlimage_init.cpp
-add_library(khtmlimagepart MODULE khtmlimage_init.cpp)
+add_library(khtmlimagepart khtmlimage_init.cpp)
 
 kservice_desktop_to_json(khtmlimagepart khtmlimage.desktop)
 
@@ -757,7 +757,7 @@ install(TARGETS khtmlimagepart  DESTINATION ${KDE_INSTALL_PLUGINDIR}/kf5/parts)
 
 ########### next target ###############
 
-add_library(khtmladaptorpart MODULE khtmladaptorpart.cpp)
+add_library(khtmladaptorpart khtmladaptorpart.cpp)
 
 target_link_libraries(khtmladaptorpart KF5::Parts KF5::JS KF5::I18n KF5::XmlGui)
 
diff --git a/src/html/kentities.cpp b/src/html/kentities.cpp
index 3169149..5665b57 100644
--- a/src/html/kentities.cpp
+++ b/src/html/kentities.cpp
@@ -27,7 +27,7 @@
 
 bool kde_findEntity(const char *str, unsigned int len, int *code)
 {
-    const entity *e = KCodecsEntities::kde_findEntity(str, len);
+    const entity *e = KHtmlEntities::kde_findEntity(str, len);
     if (!e) {
         return false;
     }
diff --git a/src/html/kentities.gperf b/src/html/kentities.gperf
index 90ba88a..45769e3 100644
--- a/src/html/kentities.gperf
+++ b/src/html/kentities.gperf
@@ -6,7 +6,7 @@
 %define lookup-function-name kde_findEntity
 %define hash-function-name hash_Entity
 %define word-array-name wordlist_Entity
-%define class-name KCodecsEntities
+%define class-name KHtmlEntities
 %{
 /*   This file is part of the KDE libraries
   
diff --git a/src/java/CMakeLists.txt b/src/java/CMakeLists.txt
index 4f9a629..a42b3d8 100644
--- a/src/java/CMakeLists.txt
+++ b/src/java/CMakeLists.txt
@@ -14,7 +14,7 @@ set(kjavaappletviewer_PART_SRCS
 )
 ecm_qt_declare_logging_category(kjavaappletviewer_PART_SRCS HEADER kjavaappletviewer_debug.h IDENTIFIER KJAVAAPPLETVIEWER_LOG CATEGORY_NAME kf5.khtml.javaappletviewer)
 
-add_library(kjavaappletviewer MODULE ${kjavaappletviewer_PART_SRCS})
+add_library(kjavaappletviewer ${kjavaappletviewer_PART_SRCS})
 
 target_link_libraries(kjavaappletviewer
                       Qt5::Network
diff --git a/src/kmultipart/CMakeLists.txt b/src/kmultipart/CMakeLists.txt
index 31b456f..2efeaa5 100644
--- a/src/kmultipart/CMakeLists.txt
+++ b/src/kmultipart/CMakeLists.txt
@@ -8,7 +8,7 @@ include_directories(${ZLIB_INCLUDE_DIR})
 
 set(kmultipart_PART_SRCS kmultipart.cpp httpfiltergzip.cpp)
 ecm_qt_declare_logging_category(kmultipart_PART_SRCS HEADER kmultipart_debug.h IDENTIFIER KMULTIPART_LOG CATEGORY_NAME kf5.khtml.multipart)
-add_library(kmultipart MODULE ${kmultipart_PART_SRCS})
+add_library(kmultipart ${kmultipart_PART_SRCS})
 
 target_link_libraries(kmultipart
                         ${ZLIB_LIBRARY}
EOF
echo ./source/frameworks/kirigami
git -C ./source/frameworks/kirigami checkout .
patch -p1 -d ./source/frameworks/kirigami <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bd49133..9f95605 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -17,13 +17,13 @@ endif()
 
 option(BUILD_SHARED_LIBS "Build a shared module" ON)
 option(DESKTOP_ENABLED "Build and install The Desktop style" ON)
-option(STATIC_LIBRARY "Build as a static library (deprecated, use BUILD_SHARED_LIBS instead)" OFF)
+option(STATIC_LIBRARY_FLAG "Build as a static library (deprecated, use BUILD_SHARED_LIBS instead)" OFF)
 option(BUILD_EXAMPLES "Build and install examples" OFF)
 option(DISABLE_DBUS "Build without D-Bus support" OFF)
 
 if(NOT BUILD_SHARED_LIBS)
-    set(STATIC_LIBRARY 1)
-elseif(STATIC_LIBRARY)
+    set(STATIC_LIBRARY_FLAG 1)
+elseif(STATIC_LIBRARY_FLAG)
     set(BUILD_SHARED_LIBS 0)
 endif()
 
@@ -40,15 +40,15 @@ set(CMAKE_AUTOMOC ON)
 set(AUTOMOC_MOC_OPTIONS -Muri=org.kde.kirigami)
 set(CMAKE_INCLUDE_CURRENT_DIR ON)
 
-if(STATIC_LIBRARY)
+if(STATIC_LIBRARY_FLAG)
     add_definitions(-DKIRIGAMI_BUILD_TYPE_STATIC)
     add_definitions(-DQT_PLUGIN)
     add_definitions(-DQT_STATICPLUGIN=1)
-else(STATIC_LIBRARY)
+else(STATIC_LIBRARY_FLAG)
     if (BUILD_TESTING)
         add_subdirectory(autotests)
     endif()
-endif(STATIC_LIBRARY)
+endif(STATIC_LIBRARY_FLAG)
 
 ################# set KDE specific information #################
 
@@ -120,7 +120,7 @@ ecm_find_qmlmodule(QtGraphicalEffects 1.0)
 
 add_subdirectory(src)
 
-if (BUILD_EXAMPLES AND NOT STATIC_LIBRARY)
+if (BUILD_EXAMPLES AND NOT STATIC_LIBRARY_FLAG)
     add_subdirectory(examples)
 endif()
 
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 3e1c35a..1579831 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -1,6 +1,6 @@
 project(kirigami)
 
-if (NOT STATIC_LIBRARY)
+if (NOT STATIC_LIBRARY_FLAG)
     ecm_create_qm_loader(kirigami_QM_LOADER libkirigami2plugin_qt)
 else()
     set(KIRIGAMI_STATIC_FILES
@@ -27,7 +27,7 @@ set(kirigami_SRCS
 
 add_subdirectory(libkirigami)
 
-if(STATIC_LIBRARY)
+if(STATIC_LIBRARY_FLAG)
     # Set some variables to insert the right files in the QRC
     if(Qt5Qml_VERSION VERSION_LESS 5.10)
         set(kirigami_ActionMenuItem ActionMenuItemQt59.qml)
@@ -52,22 +52,22 @@ if(STATIC_LIBRARY)
     qt5_add_resources(
         RESOURCES ${CMAKE_CURRENT_BINARY_DIR}/../kirigami.qrc
     )
-endif(STATIC_LIBRARY)
+endif(STATIC_LIBRARY_FLAG)
 
 
 add_library(kirigamiplugin ${kirigami_SRCS} ${RESOURCES})
 
-if(STATIC_LIBRARY)
-    SET_TARGET_PROPERTIES(kirigamiplugin PROPERTIES
-        AUTOMOC_MOC_OPTIONS -Muri=org.kde.kirigami)
+if(STATIC_LIBRARY_FLAG)
+#    SET_TARGET_PROPERTIES(kirigamiplugin PROPERTIES
+#        AUTOMOC_MOC_OPTIONS -Muri=org.kde.kirigami)
     if (UNIX AND NOT CMAKE_SYSTEM_NAME STREQUAL "Android" AND NOT(APPLE) AND NOT(DISABLE_DBUS))
         set(Kirigami_EXTRA_LIBS Qt5::DBus)
     else()
         set(Kirigami_EXTRA_LIBS "")
     endif()
-else(STATIC_LIBRARY)
+else(STATIC_LIBRARY_FLAG)
     set(Kirigami_EXTRA_LIBS KF5::Kirigami2)
-endif(STATIC_LIBRARY)
+endif(STATIC_LIBRARY_FLAG)
 
 
 target_link_libraries(kirigamiplugin
@@ -77,7 +77,7 @@ target_link_libraries(kirigamiplugin
             ${Kirigami_EXTRA_LIBS} Qt5::Qml Qt5::Quick Qt5::QuickControls2
     )
 
-if (NOT STATIC_LIBRARY)
+if (NOT STATIC_LIBRARY_FLAG)
 
     add_custom_target(copy)
 
@@ -118,6 +118,6 @@ if (NOT STATIC_LIBRARY)
     install(FILES ${PRI_FILENAME}
             DESTINATION ${ECM_MKSPECS_INSTALL_DIR})
 
-endif(NOT STATIC_LIBRARY)
+endif(NOT STATIC_LIBRARY_FLAG)
 
 install(TARGETS kirigamiplugin DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/kirigami.2)
EOF
echo ./source/frameworks/kdelibs4support
git -C ./source/frameworks/kdelibs4support checkout .
patch -p1 -d ./source/frameworks/kdelibs4support <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 152cea79..7e5274ab 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -20,7 +20,7 @@ include(GenerateExportHeader)
 include(CMakeFindFrameworks)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Network Widgets DBus Test Svg PrintSupport Designer)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Network Widgets DBus Test Svg PrintSupport Concurrent TextToSpeech)
 
 find_package(KF5Completion ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
@@ -44,6 +44,10 @@ find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KDED ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+
+find_package(Phonon4Qt5 4.6.60 NO_MODULE)
 
 if(WIN32)
     find_package(KDEWin REQUIRED)
diff --git a/autotests/CMakeLists.txt b/autotests/CMakeLists.txt
index 2d9d3af0..cdff4882 100644
--- a/autotests/CMakeLists.txt
+++ b/autotests/CMakeLists.txt
@@ -78,7 +78,7 @@ if(NOT KDELIBS4SUPPORT_NO_DEPRECATED)
   # even though the module cannot be loaded
   set(klibloadertestmodule3_PART_SRCS klibloadertest3_module.cpp )
 
-  add_library(klibloadertestmodule3 MODULE ${klibloadertestmodule3_PART_SRCS})
+  add_library(klibloadertestmodule3 STATIC ${klibloadertestmodule3_PART_SRCS})
   set_target_properties(klibloadertestmodule3 PROPERTIES PREFIX "") # remove lib prefix - missing from cmake
 
   target_link_libraries(klibloadertestmodule3 KF5::KDELibs4Support Qt5::Test KF5::I18n KF5::Service KF5::CoreAddons)
@@ -90,7 +90,7 @@ endif()
 
 set(klibloadertestmodule5_PART_SRCS klibloadertest5_module.cpp )
 
-add_library(klibloadertestmodule5 MODULE ${klibloadertestmodule5_PART_SRCS})
+add_library(klibloadertestmodule5 STATIC ${klibloadertestmodule5_PART_SRCS})
 ecm_mark_as_test(klibloadertestmodule5)
 set_target_properties(klibloadertestmodule5 PROPERTIES PREFIX "") # remove lib prefix - missing from cmake
 
diff --git a/cmake/modules/KDE4Macros.cmake b/cmake/modules/KDE4Macros.cmake
index ca868ad9..5a90ede5 100644
--- a/cmake/modules/KDE4Macros.cmake
+++ b/cmake/modules/KDE4Macros.cmake
@@ -263,7 +263,7 @@ macro (KDE4_ADD_KDEINIT_EXECUTABLE _target_NAME )
       target_link_libraries(${_target_NAME} kdeinit_${_target_NAME})
    else(WIN32)
 
-      add_library(kdeinit_${_target_NAME} SHARED ${_SRCS})
+      add_library(kdeinit_${_target_NAME} ${_SRCS})
 
       set_target_properties(kdeinit_${_target_NAME} PROPERTIES OUTPUT_NAME kdeinit5_${_target_NAME})
 
diff --git a/cmake/modules/SIPMacros.cmake b/cmake/modules/SIPMacros.cmake
index 28c1cf4c..a3bccd43 100644
--- a/cmake/modules/SIPMacros.cmake
+++ b/cmake/modules/SIPMacros.cmake
@@ -103,9 +103,9 @@ MACRO(ADD_SIP_PYTHON_MODULE MODULE_NAME MODULE_SIP)
         ENDFOREACH(filename ${_sip_output_files})
     ENDIF(NOT WIN32)
     ADD_CUSTOM_COMMAND(
-        OUTPUT ${_sip_output_files} 
+        OUTPUT ${_sip_output_files}
         COMMAND ${CMAKE_COMMAND} -E echo ${message}
-        COMMAND ${TOUCH_COMMAND} ${_sip_output_files} 
+        COMMAND ${TOUCH_COMMAND} ${_sip_output_files}
         COMMAND ${SIP_EXECUTABLE} ${_sip_tags} ${_sip_x} ${SIP_EXTRA_OPTIONS} -j ${SIP_CONCAT_PARTS} -c ${CMAKE_CURRENT_SIP_OUTPUT_DIR} ${_sip_includes} ${_abs_module_sip}
         DEPENDS ${_abs_module_sip} ${SIP_EXTRA_FILES_DEPEND}
     )
@@ -113,7 +113,7 @@ MACRO(ADD_SIP_PYTHON_MODULE MODULE_NAME MODULE_SIP)
     IF (CYGWIN)
         ADD_LIBRARY(${_logical_name} MODULE ${_sip_output_files} )
     ELSE (CYGWIN)
-        ADD_LIBRARY(${_logical_name} SHARED ${_sip_output_files} )
+        ADD_LIBRARY(${_logical_name} ${_sip_output_files} )
     ENDIF (CYGWIN)
     TARGET_LINK_LIBRARIES(${_logical_name} ${PYTHON_LIBRARY})
     TARGET_LINK_LIBRARIES(${_logical_name} ${EXTRA_LINK_LIBRARIES})
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index ab0b2465..8f321c8e 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -529,7 +529,7 @@ install(FILES
 
 configure_file(kssl/ksslconfig.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/kssl/ksslconfig.h )
 set_property(DIRECTORY APPEND PROPERTY ADDITIONAL_MAKE_CLEAN_FILES ${CMAKE_CURRENT_BINARY_DIR}/kssl/ksslconfig.h )
-install(FILES ${CMAKE_CURRENT_BINARY_DIR}/kssl/ksslconfig.h 
+install(FILES ${CMAKE_CURRENT_BINARY_DIR}/kssl/ksslconfig.h
   DESTINATION ${KDE_INSTALL_INCLUDEDIR_KF5}/KDELibs4Support COMPONENT Devel)
 
 install( FILES kdebug.areas kdebugrc DESTINATION ${KDE_INSTALL_CONFDIR} )
diff --git a/src/kio/dummyanalyzers/CMakeLists.txt b/src/kio/dummyanalyzers/CMakeLists.txt
index 49673277..ccc9c23d 100644
--- a/src/kio/dummyanalyzers/CMakeLists.txt
+++ b/src/kio/dummyanalyzers/CMakeLists.txt
@@ -1,6 +1,6 @@
 
 # build the analyzer as a module
-add_library(dummy MODULE dummyanalyzers.cpp)
+add_library(dummy STATIC dummyanalyzers.cpp)
 
 # link with the required libraries
 target_link_libraries(dummy ${STRIGI_STREAMANALYZER_LIBRARY})
diff --git a/src/kioslave/metainfo/CMakeLists.txt b/src/kioslave/metainfo/CMakeLists.txt
index 1538fc8e..ec7ea98d 100644
--- a/src/kioslave/metainfo/CMakeLists.txt
+++ b/src/kioslave/metainfo/CMakeLists.txt
@@ -6,7 +6,7 @@ project(kioslave-metainfo)
 set(kio_metainfo_PART_SRCS metainfo.cpp )
 
 
-add_library(kio_metainfo MODULE ${kio_metainfo_PART_SRCS})
+add_library(kio_metainfo STATIC ${kio_metainfo_PART_SRCS})
 
 
 target_link_libraries(kio_metainfo
diff --git a/src/kssl/kcm/CMakeLists.txt b/src/kssl/kcm/CMakeLists.txt
index 3a20724c..f7f1f27d 100644
--- a/src/kssl/kcm/CMakeLists.txt
+++ b/src/kssl/kcm/CMakeLists.txt
@@ -5,7 +5,7 @@ set(kcmssl_SRCS kcmssl.cpp cacertificatespage.cpp displaycertdialog.cpp)
 #todo: port to include klocalizedstring.h
 ki18n_wrap_ui(kcmssl_SRCS cacertificates.ui displaycert.ui)
 
-add_library(kcm_ssl MODULE ${kcmssl_SRCS})
+add_library(kcm_ssl STATIC ${kcmssl_SRCS})
 target_link_libraries(kcm_ssl
    Qt5::Network
    KF5::KIOCore
diff --git a/src/solid-networkstatus/kded/CMakeLists.txt b/src/solid-networkstatus/kded/CMakeLists.txt
index 9fa30651..2dce112b 100644
--- a/src/solid-networkstatus/kded/CMakeLists.txt
+++ b/src/solid-networkstatus/kded/CMakeLists.txt
@@ -54,7 +54,7 @@ qt5_add_dbus_adaptor(kded_networkstatus_PART_SRCS
         networkstatus.h NetworkStatusModule)
 
 
-add_library(kded_networkstatus MODULE ${kded_networkstatus_PART_SRCS})
+add_library(kded_networkstatus STATIC ${kded_networkstatus_PART_SRCS})
 set_target_properties(kded_networkstatus PROPERTIES
     OUTPUT_NAME networkstatus
 )
EOF
echo ./source/frameworks/kjs
git -C ./source/frameworks/kjs checkout .
patch -p1 -d ./source/frameworks/kjs <<'EOF'
diff --git a/src/wtf/CMakeLists.txt b/src/wtf/CMakeLists.txt
index c05f7a4..f1ec9c8 100644
--- a/src/wtf/CMakeLists.txt
+++ b/src/wtf/CMakeLists.txt
@@ -4,7 +4,7 @@
 
 #set(wtf_LIB_SRCS HashTable.cpp )
 
-#add_library(wtf SHARED ${wtf_LIB_SRCS})
+#add_library(wtf ${wtf_LIB_SRCS})
 
 #set_target_properties(wtf PROPERTIES VERSION ${GENERIC_LIB_VERSION} SOVERSION ${GENERIC_LIB_SOVERSION} )
 #install(TARGETS wtf ${KF5_INSTALL_TARGETS_DEFAULT_ARGS} )
EOF
echo ./source/frameworks/plasma-framework
git -C ./source/frameworks/plasma-framework checkout .
patch -p1 -d ./source/frameworks/plasma-framework <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 1edcd913f..3c30bad57 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -43,7 +43,7 @@ endif()
 
 set (REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Quick Gui Sql Qml Svg QuickControls2)
+find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Quick Gui Sql Qml Svg QuickControls2 Concurrent PrintSupport TextToSpeech)
 
 find_package(KF5 ${KF5_DEP_VERSION} REQUIRED
     COMPONENTS
@@ -65,11 +65,17 @@ find_package(KF5 ${KF5_DEP_VERSION} REQUIRED
         Notifications
         Package
         Kirigami2
+        Attica
+        TextWidgets
     OPTIONAL_COMPONENTS
         Wayland
         DocTools
 )
 
+find_package(Phonon4Qt5 4.6.60)
+find_package(Wayland)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
+
 set_package_properties(KF5Wayland PROPERTIES DESCRIPTION "Integration with the Wayland compositor"
                        TYPE OPTIONAL
                       )
diff --git a/KF5PlasmaMacros.cmake b/KF5PlasmaMacros.cmake
index 494b42d56..a268b1910 100644
--- a/KF5PlasmaMacros.cmake
+++ b/KF5PlasmaMacros.cmake
@@ -83,7 +83,7 @@ endmacro()
 macro(plasma_add_plugin plugin)
     message(WARNING "plasma_add_plugin() is deprecated, use add_library(MODULE) instead. You can use the porting scripts in plasma-framework/tools")
     set(plugin_sources ${ARGN} )
-    add_library(${plugin} MODULE ${plugin_sources} )
+    add_library(${plugin} STATIC ${plugin_sources} )
     set_target_properties(${plugin} PROPERTIES PREFIX "")
 endmacro()
 
diff --git a/examples/dataengines/customDataContainers/CMakeLists.txt b/examples/dataengines/customDataContainers/CMakeLists.txt
index 3ef869093..ff485ac1a 100644
--- a/examples/dataengines/customDataContainers/CMakeLists.txt
+++ b/examples/dataengines/customDataContainers/CMakeLists.txt
@@ -3,7 +3,7 @@ set(customDataContainers_SRCS
     httpContainer.cpp
 )
 
-add_library(plasma_dataengine_example_customDataContainers MODULE ${customDataContainers_SRCS})
+add_library(plasma_dataengine_example_customDataContainers STATIC ${customDataContainers_SRCS})
 
 kcoreaddons_desktop_to_json(plasma_dataengine_example_customDataContainers plasma-dataengine-example-customDataContainers.desktop)
 
diff --git a/examples/dataengines/simpleEngine/CMakeLists.txt b/examples/dataengines/simpleEngine/CMakeLists.txt
index 13fdf8e07..068c27c42 100644
--- a/examples/dataengines/simpleEngine/CMakeLists.txt
+++ b/examples/dataengines/simpleEngine/CMakeLists.txt
@@ -2,7 +2,7 @@ set(simpleEngine_SRCS
     simpleEngine.cpp
 )
 
-add_library(plasma_dataengine_example_simpleEngine MODULE ${simpleEngine_SRCS})
+add_library(plasma_dataengine_example_simpleEngine STATIC ${simpleEngine_SRCS})
 
 kcoreaddons_desktop_to_json(plasma_dataengine_example_simpleEngine plasma-dataengine-example-simpleEngine.desktop)
 
diff --git a/examples/dataengines/sourcesOnRequest/CMakeLists.txt b/examples/dataengines/sourcesOnRequest/CMakeLists.txt
index aea248d2c..7a9809d12 100644
--- a/examples/dataengines/sourcesOnRequest/CMakeLists.txt
+++ b/examples/dataengines/sourcesOnRequest/CMakeLists.txt
@@ -2,7 +2,7 @@ set(sourcesOnRequest_SRCS
     sourcesOnRequest.cpp
 )
 
-add_library(plasma_dataengine_example_sourcesOnRequest MODULE ${sourcesOnRequest_SRCS})
+add_library(plasma_dataengine_example_sourcesOnRequest STATIC ${sourcesOnRequest_SRCS})
 
 kcoreaddons_desktop_to_json(plasma_dataengine_example_sourcesOnRequest plasma-dataengine-example-sourcesOnRequest.desktop)
 
diff --git a/examples/testcontainmentactionsplugin/CMakeLists.txt b/examples/testcontainmentactionsplugin/CMakeLists.txt
index 62d649714..31135b872 100644
--- a/examples/testcontainmentactionsplugin/CMakeLists.txt
+++ b/examples/testcontainmentactionsplugin/CMakeLists.txt
@@ -3,7 +3,7 @@ set(test_SRCS
 )
 ki18n_wrap_ui(test_SRCS config.ui)
 
-add_library(plasma_containmentactions_test MODULE ${test_SRCS})
+add_library(plasma_containmentactions_test STATIC ${test_SRCS})
 target_link_libraries(plasma_containmentactions_test KF5::Plasma KF5::I18n KF5::KIOWidgets KF5::XmlGui)
 
 install(TARGETS plasma_containmentactions_test DESTINATION ${KDE_INSTALL_PLUGINDIR})
diff --git a/src/declarativeimports/calendar/CMakeLists.txt b/src/declarativeimports/calendar/CMakeLists.txt
index 9316419cb..68d9104c0 100644
--- a/src/declarativeimports/calendar/CMakeLists.txt
+++ b/src/declarativeimports/calendar/CMakeLists.txt
@@ -11,7 +11,7 @@ set(calendar_SRCS
     eventpluginsmanager.cpp
 )
 
-add_library(calendarplugin SHARED ${calendar_SRCS})
+add_library(calendarplugin ${calendar_SRCS})
 
 target_link_libraries(calendarplugin
     Qt5::Core
diff --git a/src/declarativeimports/core/CMakeLists.txt b/src/declarativeimports/core/CMakeLists.txt
index 26b5829f6..e7a3233c9 100644
--- a/src/declarativeimports/core/CMakeLists.txt
+++ b/src/declarativeimports/core/CMakeLists.txt
@@ -26,7 +26,7 @@ set(corebindings_SRCS
 
 qt5_add_resources(corebindings_SRCS shaders.qrc)
 
-add_library(corebindingsplugin SHARED ${corebindings_SRCS})
+add_library(corebindingsplugin ${corebindings_SRCS})
 target_link_libraries(corebindingsplugin
         Qt5::Quick
         Qt5::Qml
diff --git a/src/declarativeimports/plasmacomponents/CMakeLists.txt b/src/declarativeimports/plasmacomponents/CMakeLists.txt
index 59ee81309..c7a6a9be7 100644
--- a/src/declarativeimports/plasmacomponents/CMakeLists.txt
+++ b/src/declarativeimports/plasmacomponents/CMakeLists.txt
@@ -10,7 +10,7 @@ set(plasmacomponents_SRCS
     qmenuitem.cpp
     )
 
-add_library(plasmacomponentsplugin SHARED ${plasmacomponents_SRCS})
+add_library(plasmacomponentsplugin ${plasmacomponents_SRCS})
 target_link_libraries(plasmacomponentsplugin
         Qt5::Core
         Qt5::Quick
diff --git a/src/declarativeimports/plasmaextracomponents/CMakeLists.txt b/src/declarativeimports/plasmaextracomponents/CMakeLists.txt
index 5b1400020..7df12a646 100644
--- a/src/declarativeimports/plasmaextracomponents/CMakeLists.txt
+++ b/src/declarativeimports/plasmaextracomponents/CMakeLists.txt
@@ -11,7 +11,7 @@ set(plasmaextracomponents_SRCS
     fallbackcomponent.cpp
     )
 
-add_library(plasmaextracomponentsplugin SHARED ${plasmaextracomponents_SRCS})
+add_library(plasmaextracomponentsplugin ${plasmaextracomponents_SRCS})
 
 target_link_libraries(plasmaextracomponentsplugin
         Qt5::Quick
diff --git a/src/declarativeimports/platformcomponents/CMakeLists.txt b/src/declarativeimports/platformcomponents/CMakeLists.txt
index 34e7f7ba5..4f925949b 100644
--- a/src/declarativeimports/platformcomponents/CMakeLists.txt
+++ b/src/declarativeimports/platformcomponents/CMakeLists.txt
@@ -7,7 +7,7 @@ set(platformcomponents_SRCS
     icondialog.cpp
     )
 
-add_library(platformcomponentsplugin SHARED ${platformcomponents_SRCS})
+add_library(platformcomponentsplugin ${platformcomponents_SRCS})
 
 target_link_libraries(
     platformcomponentsplugin
diff --git a/src/plasma/packagestructure/CMakeLists.txt b/src/plasma/packagestructure/CMakeLists.txt
index 9d62638b9..b0d1a3840 100644
--- a/src/plasma/packagestructure/CMakeLists.txt
+++ b/src/plasma/packagestructure/CMakeLists.txt
@@ -1,5 +1,5 @@
 function(install_package_structure name)
-    add_library(${name}_packagestructure MODULE ${name}package.cpp packages.cpp)
+    add_library(${name}_packagestructure STATIC ${name}package.cpp packages.cpp)
     target_link_libraries(${name}_packagestructure PRIVATE KF5::Package KF5::Plasma KF5::Declarative KF5::I18n)
     install(TARGETS ${name}_packagestructure DESTINATION ${KDE_INSTALL_PLUGINDIR}/kpackage/packagestructure)
 endfunction()
diff --git a/src/plasma/private/framesvg_helpers.h b/src/plasma/private/framesvg_helpers.h
index 08c233a9c..dcb4914af 100644
--- a/src/plasma/private/framesvg_helpers.h
+++ b/src/plasma/private/framesvg_helpers.h
@@ -31,7 +31,7 @@ namespace FrameSvgHelpers
 /**
  * @returns the element id name for said @p borders
  */
-QString borderToElementId(FrameSvg::EnabledBorders borders)
+static QString borderToElementId(FrameSvg::EnabledBorders borders)
 {
     if (borders == FrameSvg::NoBorder) {
         return QStringLiteral("center");
@@ -60,7 +60,7 @@ QString borderToElementId(FrameSvg::EnabledBorders borders)
 /**
  * @returns the suggested geometry for the @p borders given a @p fullSize frame size and a @p contentRect
  */
-QRect sectionRect(Plasma::FrameSvg::EnabledBorders borders, const QRect& contentRect, const QSize& fullSize)
+static QRect sectionRect(Plasma::FrameSvg::EnabledBorders borders, const QRect& contentRect, const QSize& fullSize)
 {
     //don't use QRect corner methods here, they have semantics that might come as unexpected.
     //prefer constructing the points explicitly. e.g. from QRect::topRight docs:
diff --git a/src/plasmaquick/CMakeLists.txt b/src/plasmaquick/CMakeLists.txt
index d0f1e3c51..07bd4c9de 100644
--- a/src/plasmaquick/CMakeLists.txt
+++ b/src/plasmaquick/CMakeLists.txt
@@ -23,7 +23,7 @@ set(plasmaquick_LIB_SRC
 
 ecm_qt_declare_logging_category(PlasmaQuick_LIB_SRCS HEADER debug_p.h IDENTIFIER LOG_PLASMAQUICK CATEGORY_NAME org.kde.plasmaquick)
 
-add_library(KF5PlasmaQuick SHARED ${plasmaquick_LIB_SRC})
+add_library(KF5PlasmaQuick ${plasmaquick_LIB_SRC})
 add_library(KF5::PlasmaQuick ALIAS KF5PlasmaQuick)
 target_include_directories(KF5PlasmaQuick PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR};${CMAKE_CURRENT_BINARY_DIR}/..>")
 
diff --git a/src/scriptengines/qml/CMakeLists.txt b/src/scriptengines/qml/CMakeLists.txt
index 68499f091..8a7d0cdc5 100644
--- a/src/scriptengines/qml/CMakeLists.txt
+++ b/src/scriptengines/qml/CMakeLists.txt
@@ -15,7 +15,7 @@ set(declarative_appletscript_SRCS
     plasmoid/wallpaperinterface.cpp
     )
 
-add_library(plasma_appletscript_declarative MODULE ${declarative_appletscript_SRCS} )
+add_library(plasma_appletscript_declarative STATIC ${declarative_appletscript_SRCS} )
 set_target_properties(plasma_appletscript_declarative PROPERTIES PREFIX "")
 
 kcoreaddons_desktop_to_json(
diff --git a/templates/cpp-plasmoid/src/CMakeLists.txt b/templates/cpp-plasmoid/src/CMakeLists.txt
index 548e77732..c47d8a40b 100644
--- a/templates/cpp-plasmoid/src/CMakeLists.txt
+++ b/templates/cpp-plasmoid/src/CMakeLists.txt
@@ -5,7 +5,7 @@ set(%{APPNAMELC}_SRCS
     %{APPNAMELC}.cpp
 )
 
-add_library(plasma_applet_%{APPNAMELC} MODULE ${%{APPNAMELC}_SRCS})
+add_library(plasma_applet_%{APPNAMELC} STATIC ${%{APPNAMELC}_SRCS})
 
 kcoreaddons_desktop_to_json(plasma_applet_%{APPNAMELC} package/metadata.desktop SERVICE_TYPES plasma-applet.desktop)
 
diff --git a/templates/qml-plasmoid-with-qml-extension/plugin/CMakeLists.txt b/templates/qml-plasmoid-with-qml-extension/plugin/CMakeLists.txt
index 46cdf13ab..17342e7dc 100644
--- a/templates/qml-plasmoid-with-qml-extension/plugin/CMakeLists.txt
+++ b/templates/qml-plasmoid-with-qml-extension/plugin/CMakeLists.txt
@@ -4,7 +4,7 @@ set(%{APPNAMELC}plugin_SRCS
     %{APPNAMELC}plugin.cpp
 )
 
-add_library(%{APPNAMELC}plugin SHARED ${%{APPNAMELC}plugin_SRCS})
+add_library(%{APPNAMELC}plugin ${%{APPNAMELC}plugin_SRCS})
 
 target_link_libraries(%{APPNAMELC}plugin
     KF5::I18n
diff --git a/tests/testengine/CMakeLists.txt b/tests/testengine/CMakeLists.txt
index e9b1270ec..65871c1f9 100644
--- a/tests/testengine/CMakeLists.txt
+++ b/tests/testengine/CMakeLists.txt
@@ -1,4 +1,4 @@
-add_library(plasma_engine_testengine MODULE testengine.cpp)
+add_library(plasma_engine_testengine STATIC testengine.cpp)
 
 kcoreaddons_desktop_to_json(
     plasma_engine_testengine plasma-dataengine-testengine.desktop
EOF
echo ./source/frameworks/kglobalaccel
git -C ./source/frameworks/kglobalaccel checkout .
patch -p1 -d ./source/frameworks/kglobalaccel <<'EOF'
diff --git a/src/runtime/plugins/xcb/CMakeLists.txt b/src/runtime/plugins/xcb/CMakeLists.txt
index b76477f..a39f8e7 100644
--- a/src/runtime/plugins/xcb/CMakeLists.txt
+++ b/src/runtime/plugins/xcb/CMakeLists.txt
@@ -3,7 +3,7 @@ set(xcb_plugin_SRCS
     ../../logging.cpp
 )
 
-add_library(KF5GlobalAccelPrivateXcb MODULE ${xcb_plugin_SRCS})
+add_library(KF5GlobalAccelPrivateXcb STATIC ${xcb_plugin_SRCS})
 target_link_libraries(KF5GlobalAccelPrivateXcb
     KF5GlobalAccelPrivate
     XCB::XCB
EOF
echo ./source/frameworks/kservice
git -C ./source/frameworks/kservice checkout .
patch -p1 -d ./source/frameworks/kservice <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index f09f2c2..872f8c6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -41,7 +41,7 @@ set(APPLICATIONS_MENU_NAME applications.menu
 
 # Dependencies
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED DBus Xml)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED DBus Xml X11Extras)
 
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
@@ -49,6 +49,7 @@ find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DocTools ${KF5_DEP_VERSION})
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 
 find_package(FLEX REQUIRED)
 set_package_properties(FLEX PROPERTIES
diff --git a/autotests/CMakeLists.txt b/autotests/CMakeLists.txt
index b6c3a7b..69e45c2 100644
--- a/autotests/CMakeLists.txt
+++ b/autotests/CMakeLists.txt
@@ -37,7 +37,7 @@ target_sources(kservicetest PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/../src/services/ktraderparsetree.cpp
 )
 
-add_library(fakeplugin MODULE nsaplugin.cpp)
+add_library(fakeplugin STATIC nsaplugin.cpp)
 ecm_mark_as_test(fakeplugin)
 target_link_libraries(fakeplugin KF5::Service)
 
EOF
echo ./source/frameworks/ki18n
git -C ./source/frameworks/ki18n checkout .
patch -p1 -d ./source/frameworks/ki18n <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 850aaaa..cda0a5d 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -69,7 +69,7 @@ set(ktranscript_LIB_SRCS
     ktranscript.cpp
     common_helpers.cpp
 )
-add_library(ktranscript MODULE ${ktranscript_LIB_SRCS})
+add_library(ktranscript STATIC ${ktranscript_LIB_SRCS})
 generate_export_header(ktranscript BASE_NAME KTranscript)
 target_link_libraries(ktranscript PRIVATE Qt5::Qml Qt5::Core)
 
EOF
echo ./source/frameworks/knotifyconfig
git -C ./source/frameworks/knotifyconfig checkout .
patch -p1 -d ./source/frameworks/knotifyconfig <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 66c5782..7bc6254 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -15,7 +15,7 @@ set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 set(REQUIRED_QT_VERSION 5.9.0)
 
 # Required Qt5 components to build this framework
-find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets DBus)
+find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets DBus Concurrent PrintSupport X11Extras Svg)
 find_package(Qt5 ${REQUIRED_QT_VERSION} QUIET OPTIONAL_COMPONENTS TextToSpeech)
 if (NOT Qt5TextToSpeech_FOUND)
   message(STATUS "Qt5TextToSpeech not found, speech features will be disabled")
@@ -31,6 +31,15 @@ find_package(KF5Completion ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5KIO ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 # Includes
 
EOF
echo ./source/frameworks/kdnssd
git -C ./source/frameworks/kdnssd checkout .
patch -p1 -d ./source/frameworks/kdnssd <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 4a76703..2847a66 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -44,7 +44,7 @@ else ()
 
 endif ()
 
-add_library(KF5DNSSD SHARED ${kdnssd_LIB_SRCS})
+add_library(KF5DNSSD ${kdnssd_LIB_SRCS})
 generate_export_header(KF5DNSSD BASE_NAME KDNSSD
   EXPORT_FILE_NAME ${KDNSSD_BINARY_DIR}/dnssd/kdnssd_export.h
 )
EOF
echo ./source/frameworks/kcmutils
git -C ./source/frameworks/kcmutils checkout .
patch -p1 -d ./source/frameworks/kcmutils <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index be9c140..07c9fd3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -17,7 +17,7 @@ include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets DBus Qml Quick QuickWidgets)
+find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets DBus Qml Quick QuickWidgets Svg PrintSupport X11Extras TextToSpeech Concurrent)
 
 set(KCMUtils_AUTOMOC_MACRO_NAMES "KCMODULECONTAINER")
 if(NOT CMAKE_VERSION VERSION_LESS "3.10.0")
@@ -48,6 +48,16 @@ find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Declarative ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5KIO ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 add_definitions(-DTRANSLATION_DOMAIN=\"kcmutils5\")
 if (IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/po")
EOF
echo ./source/frameworks/kdesu
git -C ./source/frameworks/kdesu checkout .
patch -p1 -d ./source/frameworks/kdesu <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index b96069d..8199c4c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -14,6 +14,7 @@ set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 set(REQUIRED_QT_VERSION 5.9.0)
 find_package(Qt5Core ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
+find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED X11Extras)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -22,6 +23,7 @@ find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Pty ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
 
 #optional features
 find_package(X11)
EOF
echo ./source/frameworks/syntax-highlighting
git -C ./source/frameworks/syntax-highlighting checkout .
patch -p1 -d ./source/frameworks/syntax-highlighting <<'EOF'
diff --git a/examples/CMakeLists.txt b/examples/CMakeLists.txt
index 652b72c..534e7df 100644
--- a/examples/CMakeLists.txt
+++ b/examples/CMakeLists.txt
@@ -1,4 +1,4 @@
 if(Qt5Widgets_FOUND)
     add_executable(codeeditor codeeditor.cpp main.cpp)
-    target_link_libraries(codeeditor Qt5::Widgets KF5SyntaxHighlighting)
+    target_link_libraries(codeeditor PRIVATE Qt5::Widgets KF5SyntaxHighlighting SyntaxHighlightingData)
 endif()
diff --git a/src/cli/CMakeLists.txt b/src/cli/CMakeLists.txt
index 1131153..7796870 100644
--- a/src/cli/CMakeLists.txt
+++ b/src/cli/CMakeLists.txt
@@ -1,5 +1,5 @@
 add_executable(kate-syntax-highlighter kate-syntax-highlighter.cpp)
 ecm_mark_nongui_executable(kate-syntax-highlighter)
-target_link_libraries(kate-syntax-highlighter KF5SyntaxHighlighting)
+target_link_libraries(kate-syntax-highlighter PRIVATE KF5SyntaxHighlighting SyntaxHighlightingData)
 
 install(TARGETS kate-syntax-highlighter ${INSTALL_TARGETS_DEFAULT_ARGS})
EOF
echo ./source/frameworks/kiconthemes
git -C ./source/frameworks/kiconthemes checkout .
patch -p1 -d ./source/frameworks/kiconthemes <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 130b040..84da803 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -37,6 +37,7 @@ set(REQUIRED_QT_VERSION 5.9.0)
 find_package(Qt5Widgets ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
 find_package(Qt5Svg ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
 find_package(Qt5DBus ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
+find_package(Qt5X11Extras ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
 
 find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
@@ -44,6 +45,7 @@ find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5ConfigWidgets ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5ItemViews ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
 
 remove_definitions(-DQT_NO_CAST_FROM_ASCII)
 remove_definitions(-DQT_NO_CAST_FROM_BYTEARRAY)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 9b042d7..4aeedeb 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -88,7 +88,7 @@ include(ECMGeneratePriFile)
 ecm_generate_pri_file(BASE_NAME KIconThemes LIB_NAME KF5IconThemes DEPS "widgets" FILENAME_VAR PRI_FILENAME INCLUDE_INSTALL_DIR ${KDE_INSTALL_INCLUDEDIR_KF5}/KIconThemes)
 install(FILES ${PRI_FILENAME} DESTINATION ${ECM_MKSPECS_INSTALL_DIR})
 
-add_library(KIconEnginePlugin MODULE kiconengineplugin.cpp)
+add_library(KIconEnginePlugin STATIC kiconengineplugin.cpp)
 
 target_link_libraries(KIconEnginePlugin
     PRIVATE
diff --git a/src/tools/kiconfinder/kiconfinder.cpp b/src/tools/kiconfinder/kiconfinder.cpp
index fcd2e22..e286b9b 100644
--- a/src/tools/kiconfinder/kiconfinder.cpp
+++ b/src/tools/kiconfinder/kiconfinder.cpp
@@ -22,9 +22,12 @@
 #include <QCommandLineParser>
 #include <kiconloader.h>
 #include <../kiconthemes_version.h>
+#include <QtPlugin>
 
 #include <stdio.h>
 
+Q_IMPORT_PLUGIN(QXcbIntegrationPlugin)
+
 int main(int argc, char *argv[])
 {
     QGuiApplication app(argc, argv);
EOF
echo ./source/frameworks/solid
git -C ./source/frameworks/solid checkout .
patch -p1 -d ./source/frameworks/solid <<'EOF'
diff --git a/src/imports/CMakeLists.txt b/src/imports/CMakeLists.txt
index d0a4a7b..1d4c3b0 100644
--- a/src/imports/CMakeLists.txt
+++ b/src/imports/CMakeLists.txt
@@ -18,7 +18,7 @@ set(solidextensionplugin_SRCS
     devices.cpp
     )
 
-add_library(solidextensionplugin SHARED ${solidextensionplugin_SRCS})
+add_library(solidextensionplugin ${solidextensionplugin_SRCS})
 
 target_link_libraries(
     solidextensionplugin
EOF
echo ./source/frameworks/kded
git -C ./source/frameworks/kded checkout .
patch -p1 -d ./source/frameworks/kded <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c83112d..73b1762 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -12,7 +12,7 @@ feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKA
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 "${REQUIRED_QT_VERSION}" CONFIG REQUIRED DBus Widgets)
+find_package(Qt5 "${REQUIRED_QT_VERSION}" CONFIG REQUIRED DBus Widgets X11Extras)
 
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
@@ -25,6 +25,8 @@ find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DocTools ${KF5_DEP_VERSION})
 find_package(KF5Init ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5I18n ${KF5_DEP_VERSION})
+find_package(KF5WindowSystem ${KF5_DEP_VERSION})
 
 
 include(CMakePackageConfigHelpers)
EOF
echo ./source/frameworks/frameworkintegration
git -C ./source/frameworks/frameworkintegration checkout .
patch -p1 -d ./source/frameworks/frameworkintegration <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 1f19262..ff5eaaf 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -23,7 +23,7 @@ include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED DBus Widgets)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED DBus Widgets Svg TextToSpeech X11Extras)
 
 
 ecm_setup_version(PROJECT VARIABLE_PREFIX FRAMEWORKINTEGRATION
@@ -44,8 +44,14 @@ if (BUILD_KPACKAGE_INSTALL_HANDLERS)
    find_package(KF5Package ${KF5_DEP_VERSION} REQUIRED)
    find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
 
-   find_package(packagekitqt5)
-   find_package(AppStreamQt 0.10.4)
+   find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+   find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+   find_package(KF5ItemViews ${KF5_DEP_VERSION} REQUIRED)
+   find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+   find_package(Phonon4Qt5 4.6.60)
+
+#   find_package(packagekitqt5)
+#   find_package(AppStreamQt 0.10.4)
 endif()
 
 add_subdirectory(src)
diff --git a/src/integrationplugin/CMakeLists.txt b/src/integrationplugin/CMakeLists.txt
index fc28857..e454fd3 100644
--- a/src/integrationplugin/CMakeLists.txt
+++ b/src/integrationplugin/CMakeLists.txt
@@ -1,6 +1,6 @@
 
 add_library(FrameworkIntegrationPlugin
-    MODULE frameworkintegrationplugin.cpp)
+    STATIC frameworkintegrationplugin.cpp)
 
 target_link_libraries(FrameworkIntegrationPlugin
     PRIVATE
EOF
echo ./source/frameworks/kwindowsystem
git -C ./source/frameworks/kwindowsystem checkout .
patch -p1 -d ./source/frameworks/kwindowsystem <<'EOF'
diff --git a/src/platforms/wayland/CMakeLists.txt b/src/platforms/wayland/CMakeLists.txt
index 97b5592..2a7bac3 100644
--- a/src/platforms/wayland/CMakeLists.txt
+++ b/src/platforms/wayland/CMakeLists.txt
@@ -3,7 +3,7 @@ set(wayland_plugin_SRCS
     plugin.cpp
 )
 
-add_library(KF5WindowSystemWaylandPlugin MODULE ${wayland_plugin_SRCS})
+add_library(KF5WindowSystemWaylandPlugin STATIC ${wayland_plugin_SRCS})
 target_link_libraries(KF5WindowSystemWaylandPlugin
     KF5WindowSystem
 )
diff --git a/src/platforms/xcb/CMakeLists.txt b/src/platforms/xcb/CMakeLists.txt
index 99fa1ed..4557b16 100644
--- a/src/platforms/xcb/CMakeLists.txt
+++ b/src/platforms/xcb/CMakeLists.txt
@@ -8,7 +8,7 @@ set(xcb_plugin_SRCS
 )
 ecm_qt_declare_logging_category(xcb_plugin_SRCS HEADER kwindowsystem_xcb_debug.h IDENTIFIER LOG_KKEYSERVER_X11 CATEGORY_NAME org.kde.kwindowsystem.keyserver.x11 DEFAULT_SEVERITY Warning)
 
-add_library(KF5WindowSystemX11Plugin MODULE ${xcb_plugin_SRCS})
+add_library(KF5WindowSystemX11Plugin STATIC ${xcb_plugin_SRCS})
 target_link_libraries(KF5WindowSystemX11Plugin
     KF5WindowSystem
     Qt5::X11Extras
EOF
echo ./source/frameworks/ktexteditor
git -C ./source/frameworks/ktexteditor checkout .
patch -p1 -d ./source/frameworks/ktexteditor <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c01692ab..65b46035 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -42,7 +42,8 @@ set(REQUIRED_QT_VERSION 5.9.0)
 
 # Required Qt5 components to build this framework
 find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Core Widgets Qml
-  PrintSupport Xml)
+  PrintSupport Xml
+  Concurrent X11Extras Svg TextToSpeech)
 
 find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
@@ -53,6 +54,11 @@ find_package(KF5Parts ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Sonnet ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5SyntaxHighlighting ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 # libgit2 integration, at least 0.22 with proper git_libgit2_init()
 find_package(LibGit2 "0.22.0")
diff --git a/src/part/CMakeLists.txt b/src/part/CMakeLists.txt
index d2a3b25a..a9a6ef1e 100644
--- a/src/part/CMakeLists.txt
+++ b/src/part/CMakeLists.txt
@@ -1,5 +1,5 @@
 # kate part itself just is core + the factory
-add_library (katepart MODULE katepart.cpp)
+add_library (katepart STATIC katepart.cpp)
 
 # service => json and install
 kcoreaddons_desktop_to_json (katepart katepart.desktop SERVICE_TYPES kpart.desktop)
diff --git a/templates/ktexteditor-plugin/src/CMakeLists.txt b/templates/ktexteditor-plugin/src/CMakeLists.txt
index ed6c1b77..7b2f8351 100644
--- a/templates/ktexteditor-plugin/src/CMakeLists.txt
+++ b/templates/ktexteditor-plugin/src/CMakeLists.txt
@@ -5,7 +5,7 @@ set(%{APPNAMELC}_SRCS
     %{APPNAMELC}view.cpp
 )
 
-add_library(%{APPNAMELC} MODULE ${%{APPNAMELC}_SRCS})
+add_library(%{APPNAMELC} STATIC ${%{APPNAMELC}_SRCS})
 
 target_link_libraries(%{APPNAMELC}
     KF5::TextEditor
EOF
echo ./source/frameworks/kactivities-stats
git -C ./source/frameworks/kactivities-stats checkout .
patch -p1 -d ./source/frameworks/kactivities-stats <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index d0c4927..42c010a 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -33,7 +33,7 @@ qt5_add_dbus_interface (
 
 
 add_library (
-   KF5ActivitiesStats SHARED
+   KF5ActivitiesStats
    ${KActivitiesStats_LIB_SRCS}
    )
 add_library(KF5::ActivitiesStats ALIAS KF5ActivitiesStats)
EOF
echo ./source/frameworks/extra-cmake-modules
git -C ./source/frameworks/extra-cmake-modules checkout .
patch -p1 -d ./source/frameworks/extra-cmake-modules <<'EOF'
diff --git a/attic/modules/SIPMacros.cmake b/attic/modules/SIPMacros.cmake
index 7c5476e..09e0928 100644
--- a/attic/modules/SIPMacros.cmake
+++ b/attic/modules/SIPMacros.cmake
@@ -113,7 +113,7 @@ MACRO(ADD_SIP_PYTHON_MODULE MODULE_NAME MODULE_SIP)
     IF (CYGWIN)
         ADD_LIBRARY(${_logical_name} MODULE ${_sip_output_files} )
     ELSE (CYGWIN)
-        ADD_LIBRARY(${_logical_name} SHARED ${_sip_output_files} )
+        ADD_LIBRARY(${_logical_name} ${_sip_output_files} )
     ENDIF (CYGWIN)
     TARGET_LINK_LIBRARIES(${_logical_name} ${PYTHON_LIBRARY})
     TARGET_LINK_LIBRARIES(${_logical_name} ${EXTRA_LINK_LIBRARIES})
diff --git a/kde-modules/KDECMakeSettings.cmake b/kde-modules/KDECMakeSettings.cmake
index 3f7f5a8..0650c81 100644
--- a/kde-modules/KDECMakeSettings.cmake
+++ b/kde-modules/KDECMakeSettings.cmake
@@ -174,6 +174,10 @@ if(NOT KDE_SKIP_RPATH_SETTINGS)
 
 endif()
 
+# Can't do this at call time because CMake resets it :(
+set(CMAKE_FIND_LIBRARY_SUFFIXES ".a" ".so")
+set(CMAKE_CXX_STANDARD_LIBRARIES ${CMAKE_CXX_STANDARD_LIBRARIES} ${KDE_STANDARD_LIBRARIES} $ENV{KDE_STANDARD_LIBRARIES})
+
 ################ Testing setup ####################################
 
 find_program(APPSTREAMCLI appstreamcli)
diff --git a/tests/ECMPoQmToolsTest/CMakeLists.txt b/tests/ECMPoQmToolsTest/CMakeLists.txt
index 2cd76f8..6b29f84 100644
--- a/tests/ECMPoQmToolsTest/CMakeLists.txt
+++ b/tests/ECMPoQmToolsTest/CMakeLists.txt
@@ -98,7 +98,7 @@ target_link_libraries(tr_test_2 PRIVATE Qt5::Core)
 #
 # module for tr_thread_test
 #
-add_library(tr_thread_module MODULE tr_thread_test_module.cpp ${QMLOADER_FILES})
+add_library(tr_thread_module STATIC tr_thread_test_module.cpp ${QMLOADER_FILES})
 target_link_libraries(tr_thread_module PRIVATE Qt5::Core)
 
 
diff --git a/tests/GenerateSipBindings/CMakeLists.txt b/tests/GenerateSipBindings/CMakeLists.txt
index 151db9f..ab3b963 100644
--- a/tests/GenerateSipBindings/CMakeLists.txt
+++ b/tests/GenerateSipBindings/CMakeLists.txt
@@ -10,7 +10,7 @@ set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)
 
 set(CMAKE_CXX_STANDARD 14)
 
-add_library(ExternalLib SHARED external_lib.cpp)
+add_library(ExternalLib external_lib.cpp)
 target_link_libraries(ExternalLib PUBLIC Qt5::Core)
 target_compile_features(ExternalLib PUBLIC cxx_nullptr)
 
EOF
echo ./source/frameworks/knotifications
git -C ./source/frameworks/knotifications checkout .
patch -p1 -d ./source/frameworks/knotifications <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index aeab2c7..3dbf23c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -33,7 +33,7 @@ ecm_setup_version(PROJECT
 # Dependencies
 set(REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus Concurrent PrintSupport X11Extras)
 find_package(Qt5 ${REQUIRED_QT_VERSION} QUIET OPTIONAL_COMPONENTS TextToSpeech)
 set_package_properties(Qt5TextToSpeech PROPERTIES
    DESCRIPTION "Qt text to speech module"
@@ -64,6 +64,13 @@ find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Codecs ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 
 find_package(Canberra)
 set_package_properties(Canberra PROPERTIES DESCRIPTION "Library for generating event sounds"
EOF
echo ./source/frameworks/kwallet
git -C ./source/frameworks/kwallet checkout .
patch -p1 -d ./source/frameworks/kwallet <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 2217330..25c6c2a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,7 +13,7 @@ feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKA
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus X11Extras TextToSpeech Svg)
 
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
@@ -32,7 +32,12 @@ find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5ItemViews ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DocTools ${KF5_DEP_VERSION})
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+
+find_package(Phonon4Qt5 4.6.60 NO_MODULE)
 
 add_definitions(-DTRANSLATION_DOMAIN=\"kwalletd5\")
 if (IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/po")
diff --git a/src/runtime/kwalletd/backend/CMakeLists.txt b/src/runtime/kwalletd/backend/CMakeLists.txt
index fdd4710..a94f8e0 100644
--- a/src/runtime/kwalletd/backend/CMakeLists.txt
+++ b/src/runtime/kwalletd/backend/CMakeLists.txt
@@ -43,7 +43,7 @@ set(kwalletbackend_LIB_SRCS
 ecm_qt_declare_logging_category(kwalletbackend_LIB_SRCS HEADER kwalletbackend_debug.h IDENTIFIER KWALLETBACKEND_LOG CATEGORY_NAME kf5.kwallet.kwalletbackend)
 
 
-add_library(kwalletbackend5 SHARED ${kwalletbackend_LIB_SRCS})
+add_library(kwalletbackend5 ${kwalletbackend_LIB_SRCS})
 generate_export_header(kwalletbackend5)
 
 ecm_setup_version(${KF5_VERSION} VARIABLE_PREFIX KWALLETBACKEND SOVERSION 5)
EOF
echo ./source/frameworks/kmediaplayer
git -C ./source/frameworks/kmediaplayer checkout .
patch -p1 -d ./source/frameworks/kmediaplayer <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index e91520f..6b4f5f9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,6 +13,8 @@ find_package(ECM 5.53.0  NO_MODULE)
 set_package_properties(ECM PROPERTIES TYPE REQUIRED DESCRIPTION "Extra CMake Modules." URL "https://projects.kde.org/projects/kdesupport/extra-cmake-modules")
 feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKAGES)
 
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
+
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 include(KDEInstallDirs)
@@ -45,10 +47,17 @@ install(FILES ${CMAKE_CURRENT_BINARY_DIR}/kmediaplayer_version.h
 set(REQUIRED_QT_VERSION 5.9.0)
 find_package(Qt5DBus ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
 find_package(Qt5Widgets ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
+find_package(Qt5 ${REQUIRED_QT_VERSION} COMPONENTS Concurrent PrintSupport TextToSpeech X11Extras Svg)
 
 find_package(KF5Parts ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
-
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
 
 #
 # Subdirectories
EOF
echo ./source/frameworks/kdesignerplugin
git -C ./source/frameworks/kdesignerplugin checkout .
patch -p1 -d ./source/frameworks/kdesignerplugin <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c967812..827615e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -24,6 +24,16 @@ set_package_properties(Qt5Designer PROPERTIES
    PURPOSE "Required to build the Qt Designer plugins"
    TYPE OPTIONAL
 )
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Wallet ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Parts ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
+find_package (Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED COMPONENTS X11Extras Svg Concurrent PrintSupport TextToSpeech Sensors Positioning)
 
 include(ECMPoQmTools)
 
diff --git a/KF5DesignerPluginMacros.cmake b/KF5DesignerPluginMacros.cmake
index b404f66..d3d29fb 100644
--- a/KF5DesignerPluginMacros.cmake
+++ b/KF5DesignerPluginMacros.cmake
@@ -98,7 +98,7 @@ macro(kf5designerplugin_add_plugin target)
         get_target_property(Qt5UiPlugin_INCLUDE_DIRS Qt5::UiPlugin INTERFACE_INCLUDE_DIRECTORIES)
     endif()
     if(Qt5Designer_FOUND)
-        add_library(${target} MODULE ${_files})
+       add_library(${target} STATIC ${_files})
         target_include_directories(${target}
              PRIVATE ${Qt5UiPlugin_INCLUDE_DIRS}
              PRIVATE ${Qt5Designer_INCLUDE_DIRS}
EOF
echo ./source/frameworks/kidletime
git -C ./source/frameworks/kidletime checkout .
patch -p1 -d ./source/frameworks/kidletime <<'EOF'
diff --git a/src/plugins/osx/CMakeLists.txt b/src/plugins/osx/CMakeLists.txt
index e1b50b8..f9f20bb 100644
--- a/src/plugins/osx/CMakeLists.txt
+++ b/src/plugins/osx/CMakeLists.txt
@@ -2,7 +2,7 @@ set(osx_plugin_SRCS
     macpoller.cpp
 )
 
-add_library(KF5IdleTimeOsxPlugin MODULE ${osx_plugin_SRCS})
+add_library(KF5IdleTimeOsxPlugin STATIC ${osx_plugin_SRCS})
 target_link_libraries(KF5IdleTimeOsxPlugin
     KF5IdleTime
     "-framework CoreFoundation -framework Carbon"
diff --git a/src/plugins/windows/CMakeLists.txt b/src/plugins/windows/CMakeLists.txt
index 61c9364..ab4ae4c 100644
--- a/src/plugins/windows/CMakeLists.txt
+++ b/src/plugins/windows/CMakeLists.txt
@@ -2,7 +2,7 @@ set(windows_plugin_SRCS
     windowspoller.cpp
 )
 
-add_library(KF5IdleTimeWindowsPlugin MODULE ${windows_plugin_SRCS})
+add_library(KF5IdleTimeWindowsPlugin STATIC ${windows_plugin_SRCS})
 target_link_libraries(KF5IdleTimeWindowsPlugin
     KF5IdleTime
 )
diff --git a/src/plugins/xscreensaver/CMakeLists.txt b/src/plugins/xscreensaver/CMakeLists.txt
index 6842a03..8ca1317 100644
--- a/src/plugins/xscreensaver/CMakeLists.txt
+++ b/src/plugins/xscreensaver/CMakeLists.txt
@@ -4,7 +4,7 @@ set(xscreensaver_plugin_SRCS
 
 qt5_add_dbus_interface(xscreensaver_plugin_SRCS org.freedesktop.ScreenSaver.xml screensaver_interface)
 
-add_library(KF5IdleTimeXcbPlugin1 MODULE ${xscreensaver_plugin_SRCS})
+add_library(KF5IdleTimeXcbPlugin1 STATIC ${xscreensaver_plugin_SRCS})
 target_link_libraries(KF5IdleTimeXcbPlugin1
     KF5IdleTime
     Qt5::DBus
diff --git a/src/plugins/xsync/CMakeLists.txt b/src/plugins/xsync/CMakeLists.txt
index d31feb5..3eaefd1 100644
--- a/src/plugins/xsync/CMakeLists.txt
+++ b/src/plugins/xsync/CMakeLists.txt
@@ -7,7 +7,7 @@ set(xsync_plugin_SRCS
 
 ecm_qt_declare_logging_category(xsync_plugin_SRCS HEADER xsync_logging.h IDENTIFIER KIDLETIME_XSYNC_PLUGIN CATEGORY_NAME org.kde.kf5.idletime.xsync)
 
-add_library(KF5IdleTimeXcbPlugin0 MODULE ${xsync_plugin_SRCS})
+add_library(KF5IdleTimeXcbPlugin0 STATIC ${xsync_plugin_SRCS})
 target_link_libraries(KF5IdleTimeXcbPlugin0
     KF5IdleTime
     Qt5::X11Extras
EOF
echo ./source/frameworks/kio
git -C ./source/frameworks/kio checkout .
patch -p1 -d ./source/frameworks/kio <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 73b0f8c2..b3ee1fff 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -49,6 +49,12 @@ find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DocTools ${KF5_DEP_VERSION})
 find_package(KF5Solid ${KF5_DEP_VERSION} REQUIRED) # for kio_trash
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(Phonon4Qt5 REQUIRED)
 
 if (NOT KIOCORE_ONLY)
 find_package(KF5Bookmarks ${KF5_DEP_VERSION} REQUIRED)
@@ -72,7 +78,7 @@ set_package_properties(KF5DocTools PROPERTIES DESCRIPTION "Provides tools to gen
                       )
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus Network Concurrent Xml Test)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus Network Concurrent Xml Test Svg PrintSupport TextToSpeech)
 
 find_package(GSSAPI)
 set_package_properties(GSSAPI PROPERTIES DESCRIPTION "Allows KIO to make use of certain HTTP authentication services"
diff --git a/src/ioslaves/file/CMakeLists.txt b/src/ioslaves/file/CMakeLists.txt
index 9ab8ea32..a2ea9f46 100644
--- a/src/ioslaves/file/CMakeLists.txt
+++ b/src/ioslaves/file/CMakeLists.txt
@@ -22,7 +22,7 @@ check_include_files(sys/xattr.h HAVE_SYS_XATTR_H)
 
 configure_file(config-kioslave-file.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-kioslave-file.h )
 
-add_library(kio_file MODULE ${kio_file_PART_SRCS})
+add_library(kio_file STATIC ${kio_file_PART_SRCS})
 target_link_libraries(kio_file KF5::KIOCore KF5::I18n Qt5::DBus Qt5::Network)
 
 if(UNIX)
diff --git a/src/ioslaves/ftp/CMakeLists.txt b/src/ioslaves/ftp/CMakeLists.txt
index 8743a30f..abecdb04 100644
--- a/src/ioslaves/ftp/CMakeLists.txt
+++ b/src/ioslaves/ftp/CMakeLists.txt
@@ -13,7 +13,7 @@ ftp.cpp
 )
 
 
-add_library(kio_ftp MODULE ${kio_ftp_PART_SRCS})
+add_library(kio_ftp STATIC ${kio_ftp_PART_SRCS})
 target_link_libraries(kio_ftp Qt5::Network KF5::KIOCore KF5::I18n)
 
 set_target_properties(kio_ftp PROPERTIES OUTPUT_NAME "ftp")
diff --git a/src/ioslaves/help/CMakeLists.txt b/src/ioslaves/help/CMakeLists.txt
index 998a3cf5..f5a9a142 100644
--- a/src/ioslaves/help/CMakeLists.txt
+++ b/src/ioslaves/help/CMakeLists.txt
@@ -40,7 +40,7 @@ set(kio_help_PART_SRCS
 )
 
 
-add_library(kio_help MODULE ${kio_help_PART_SRCS})
+add_library(kio_help STATIC ${kio_help_PART_SRCS})
 
 target_link_libraries(kio_help
    Qt5::Gui # QTextDocument
@@ -64,7 +64,7 @@ install(TARGETS kio_help  DESTINATION ${KDE_INSTALL_PLUGINDIR}/kf5/kio)
 set(kio_ghelp_PART_SRCS kio_help.cpp main_ghelp.cpp xslt_help.cpp)
 
 
-add_library(kio_ghelp MODULE ${kio_ghelp_PART_SRCS})
+add_library(kio_ghelp STATIC ${kio_ghelp_PART_SRCS})
 
 target_link_libraries(kio_ghelp
    Qt5::Gui # QTextDocument
diff --git a/src/ioslaves/http/CMakeLists.txt b/src/ioslaves/http/CMakeLists.txt
index acfbb744..f32b89a0 100644
--- a/src/ioslaves/http/CMakeLists.txt
+++ b/src/ioslaves/http/CMakeLists.txt
@@ -63,7 +63,7 @@ set(kio_http_PART_SRCS
    )
 
 
-add_library(kio_http MODULE ${kio_http_PART_SRCS})
+add_library(kio_http STATIC ${kio_http_PART_SRCS})
 
 target_link_libraries(kio_http
    Qt5::DBus
diff --git a/src/ioslaves/remote/kdedmodule/CMakeLists.txt b/src/ioslaves/remote/kdedmodule/CMakeLists.txt
index 4e40d214..1eb2b2c8 100644
--- a/src/ioslaves/remote/kdedmodule/CMakeLists.txt
+++ b/src/ioslaves/remote/kdedmodule/CMakeLists.txt
@@ -1,4 +1,4 @@
-add_library(remotedirnotify MODULE remotedirnotify.cpp remotedirnotifymodule.cpp ../debug.cpp)
+add_library(remotedirnotify STATIC remotedirnotify.cpp remotedirnotifymodule.cpp ../debug.cpp)
 kcoreaddons_desktop_to_json(remotedirnotify remotedirnotify.desktop)
 
 target_link_libraries(remotedirnotify KF5::DBusAddons KF5::KIOCore)
diff --git a/src/ioslaves/trash/CMakeLists.txt b/src/ioslaves/trash/CMakeLists.txt
index 549c4baa..852620c6 100644
--- a/src/ioslaves/trash/CMakeLists.txt
+++ b/src/ioslaves/trash/CMakeLists.txt
@@ -30,7 +30,7 @@ else()
     )
   set(kio_trash_PART_SRCS kio_trash.cpp ${trashcommon_unix_SRCS} ${kio_trash_PART_DEBUG_SRCS})
 endif()
-add_library(kio_trash MODULE ${kio_trash_PART_SRCS})
+add_library(kio_trash STATIC ${kio_trash_PART_SRCS})
 
 target_link_libraries(kio_trash
   KF5::Solid
@@ -68,7 +68,7 @@ install(TARGETS ktrash5 ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
 # currently not on win32, TODO!
 if(NOT WIN32 AND NOT KIOCORE_ONLY)
     set(kcm_trash_PART_SRCS kcmtrash.cpp ${trashcommon_unix_SRCS} ${kio_trash_PART_DEBUG_SRCS})
-    add_library(kcm_trash MODULE ${kcm_trash_PART_SRCS})
+    add_library(kcm_trash STATIC ${kcm_trash_PART_SRCS})
     target_link_libraries(kcm_trash
        Qt5::DBus
        KF5::I18n
diff --git a/src/kcms/kio/CMakeLists.txt b/src/kcms/kio/CMakeLists.txt
index 3bb827fd..ea052539 100644
--- a/src/kcms/kio/CMakeLists.txt
+++ b/src/kcms/kio/CMakeLists.txt
@@ -29,7 +29,7 @@ ki18n_wrap_ui(kcm_kio_PART_SRCS
     kcookiesmanagement.ui
     kcookiespolicyselectiondlg.ui)
 
-add_library(kcm_kio MODULE ${kcm_kio_PART_SRCS})
+add_library(kcm_kio STATIC ${kcm_kio_PART_SRCS})
 
 target_link_libraries(kcm_kio
   PUBLIC
diff --git a/src/kcms/webshortcuts/CMakeLists.txt b/src/kcms/webshortcuts/CMakeLists.txt
index e00c3254..96e16475 100644
--- a/src/kcms/webshortcuts/CMakeLists.txt
+++ b/src/kcms/webshortcuts/CMakeLists.txt
@@ -1,6 +1,6 @@
 set(kcm_webshortcuts_PART_SRCS main.cpp )
 
-add_library(kcm_webshortcuts MODULE ${kcm_webshortcuts_PART_SRCS})
+add_library(kcm_webshortcuts STATIC ${kcm_webshortcuts_PART_SRCS})
 
 target_link_libraries(kcm_webshortcuts
   PUBLIC
diff --git a/src/kssld/kssld_adaptor.h b/src/kssld/kssld_adaptor.h
index 337eb362..8faaa1c4 100644
--- a/src/kssld/kssld_adaptor.h
+++ b/src/kssld/kssld_adaptor.h
@@ -27,7 +27,7 @@
 #include <QDBusAbstractAdaptor>
 #include <QDBusArgument>
 
-#include "kssld_dbusmetatypes.h"
+// #include "kssld_dbusmetatypes.h"
 
 class KSSLDAdaptor: public QDBusAbstractAdaptor
 {
@@ -39,7 +39,7 @@ public:
         : QDBusAbstractAdaptor(parent)
     {
         Q_ASSERT(parent);
-        registerMetaTypesForKSSLD();
+//         registerMetaTypesForKSSLD();
     }
 
 private:
EOF
echo ./source/frameworks/baloo
git -C ./source/frameworks/baloo checkout .
patch -p1 -d ./source/frameworks/baloo <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 2f4681f2..11d1453a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -55,8 +55,8 @@ add_feature_info(EXP ${BUILD_EXPERIMENTAL} "Build experimental features")
 
 
 # set up build dependencies
-find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Core DBus Widgets Qml Quick Test)
-find_package(KF5 ${KF5_DEP_VERSION} REQUIRED COMPONENTS CoreAddons Config DBusAddons I18n IdleTime Solid FileMetaData Crash KIO)
+find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Core DBus Widgets Qml Quick Test X11Extras Svg)
+find_package(KF5 ${KF5_DEP_VERSION} REQUIRED COMPONENTS CoreAddons Config DBusAddons I18n IdleTime Solid FileMetaData Crash KIO WindowSystem IconThemes GuiAddons Archive)
 
 find_package(LMDB)
 set_package_properties(LMDB
diff --git a/src/codecs/CMakeLists.txt b/src/codecs/CMakeLists.txt
index 9df77969..1e835129 100644
--- a/src/codecs/CMakeLists.txt
+++ b/src/codecs/CMakeLists.txt
@@ -13,3 +13,5 @@ target_link_libraries(KF5BalooCodecs
     Qt5::Core
     KF5::CoreAddons
 )
+
+install(TARGETS KF5BalooCodecs EXPORT KF5BalooTargets ${KF5_INSTALL_TARGETS_DEFAULT_ARGS} LIBRARY NAMELINK_SKIP)
diff --git a/src/kioslaves/kded/CMakeLists.txt b/src/kioslaves/kded/CMakeLists.txt
index 804c9442..3299787c 100644
--- a/src/kioslaves/kded/CMakeLists.txt
+++ b/src/kioslaves/kded/CMakeLists.txt
@@ -2,7 +2,7 @@ set (KDED_BALOOSEARCH_SRCS
      baloosearchmodule.cpp
 )
 
-add_library(baloosearchmodule MODULE ${KDED_BALOOSEARCH_SRCS})
+add_library(baloosearchmodule STATIC ${KDED_BALOOSEARCH_SRCS})
 kcoreaddons_desktop_to_json(baloosearchmodule baloosearchmodule.desktop)
 
 target_link_libraries(baloosearchmodule
diff --git a/src/kioslaves/search/CMakeLists.txt b/src/kioslaves/search/CMakeLists.txt
index 399ed740..810a03ed 100644
--- a/src/kioslaves/search/CMakeLists.txt
+++ b/src/kioslaves/search/CMakeLists.txt
@@ -1,6 +1,6 @@
 add_definitions(-DTRANSLATION_DOMAIN=\"kio5_baloosearch\")
 
-add_library(kio_baloosearch MODULE kio_search.cpp)
+add_library(kio_baloosearch STATIC kio_search.cpp)
 
 target_link_libraries(kio_baloosearch
   KF5::KIOCore
diff --git a/src/kioslaves/tags/CMakeLists.txt b/src/kioslaves/tags/CMakeLists.txt
index 496b9f4d..ec03fcbc 100644
--- a/src/kioslaves/tags/CMakeLists.txt
+++ b/src/kioslaves/tags/CMakeLists.txt
@@ -11,7 +11,7 @@ ecm_qt_declare_logging_category(tags_LIB_SRCS
                                 CATEGORY_NAME kf5.kio.kio_tags
 )
 
-add_library(tags MODULE ${tags_LIB_SRCS})
+add_library(tags STATIC ${tags_LIB_SRCS})
 
 target_link_libraries(tags
   KF5::KIOWidgets
diff --git a/src/kioslaves/timeline/CMakeLists.txt b/src/kioslaves/timeline/CMakeLists.txt
index bc3e8ca2..8336d021 100644
--- a/src/kioslaves/timeline/CMakeLists.txt
+++ b/src/kioslaves/timeline/CMakeLists.txt
@@ -12,7 +12,7 @@ ecm_qt_declare_logging_category(kio_timeline_SRCS
                                 CATEGORY_NAME kf5.kio.kio_timeline
 )
 
-add_library(timeline MODULE ${kio_timeline_SRCS})
+add_library(timeline STATIC ${kio_timeline_SRCS})
 
 target_link_libraries(timeline
   KF5::KIOWidgets
diff --git a/src/qml/CMakeLists.txt b/src/qml/CMakeLists.txt
index 97984967..b841d183 100644
--- a/src/qml/CMakeLists.txt
+++ b/src/qml/CMakeLists.txt
@@ -3,7 +3,7 @@ set(balooplugin_SRCS
     queryresultsmodel.cpp
     )
 
-add_library(balooplugin SHARED ${balooplugin_SRCS})
+add_library(balooplugin ${balooplugin_SRCS})
 target_link_libraries(balooplugin Qt5::Core Qt5::Qml KF5::Baloo)
 install(TARGETS balooplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/baloo/)
 
diff --git a/src/qml/experimental/CMakeLists.txt b/src/qml/experimental/CMakeLists.txt
index 936d0c9b..9fce64a8 100644
--- a/src/qml/experimental/CMakeLists.txt
+++ b/src/qml/experimental/CMakeLists.txt
@@ -15,7 +15,7 @@ set(baloomonitorplugin_SRCS
     ${DBUS_INTERFACES}
 )
 
-add_library(baloomonitorplugin SHARED ${baloomonitorplugin_SRCS})
+add_library(baloomonitorplugin ${baloomonitorplugin_SRCS})
 add_dependencies(baloomonitorplugin BalooDBusInterfaces)
 
 target_link_libraries(baloomonitorplugin
EOF
echo ./source/frameworks/kdewebkit
git -C ./source/frameworks/kdewebkit checkout .
patch -p1 -d ./source/frameworks/kdewebkit <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3c759b1..8d52242 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,7 +13,7 @@ feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKA
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Widgets WebKitWidgets Network)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Widgets WebKitWidgets Network Concurrent X11Extras PrintSupport TextToSpeech Svg Sensors Positioning)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -36,6 +36,14 @@ find_package(KF5JobWidgets ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Parts ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Wallet ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 remove_definitions(-DQT_NO_CAST_FROM_ASCII)
 remove_definitions(-DQT_NO_CAST_FROM_BYTEARRAY)
EOF
echo ./source/frameworks/bluez-qt
git -C ./source/frameworks/bluez-qt checkout .
patch -p1 -d ./source/frameworks/bluez-qt <<'EOF'
diff --git a/autotests/CMakeLists.txt b/autotests/CMakeLists.txt
index 888978f..1b6e17c 100644
--- a/autotests/CMakeLists.txt
+++ b/autotests/CMakeLists.txt
@@ -36,6 +36,6 @@ bluezqt_tests(
 
 if(Qt5Qml_FOUND AND Qt5QuickTest_FOUND)
     bluezqt_tests(qmltests)
-    target_link_libraries(qmltests Qt5::Qml Qt5::QuickTest)
+    target_link_libraries(qmltests Qt5::Qml Qt5::QuickTest -lQt5Quick -lQt5QmlDebug -lQt5Qml)
     add_definitions(-DBLUEZQT_QML_IMPORT_PATH="${CMAKE_CURRENT_BINARY_DIR}/../src/imports")
 endif()
diff --git a/src/imports/CMakeLists.txt b/src/imports/CMakeLists.txt
index 59668a5..38d3e59 100644
--- a/src/imports/CMakeLists.txt
+++ b/src/imports/CMakeLists.txt
@@ -12,7 +12,7 @@ set(bluezqtextensionplugin_SRCS
 configure_file(qmldir org/kde/bluezqt/qmldir COPYONLY)
 set(CMAKE_LIBRARY_OUTPUT_DIRECTORY org/kde/bluezqt)
 
-add_library(bluezqtextensionplugin SHARED ${bluezqtextensionplugin_SRCS})
+add_library(bluezqtextensionplugin ${bluezqtextensionplugin_SRCS})
 
 target_link_libraries(bluezqtextensionplugin
     Qt5::Core
EOF
echo ./source/frameworks/kdoctools
git -C ./source/frameworks/kdoctools checkout .
patch -p1 -d ./source/frameworks/kdoctools <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 24f75a4..898523a 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -34,7 +34,7 @@ ecm_qt_declare_logging_category(kdoctoolslog_core_SRCS
 )
 
 # needed by KIO, need to export it
-add_library(KF5DocTools SHARED xslt.cpp xslt_kde.cpp ${kdoctoolslog_core_SRCS})
+add_library(KF5DocTools xslt.cpp xslt_kde.cpp ${kdoctoolslog_core_SRCS})
 generate_export_header(KF5DocTools BASE_NAME KDocTools EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/kdoctools_export.h")
 add_library(KF5::DocTools ALIAS KF5DocTools)
 if (NOT MEINPROC_NO_KARCHIVE)
@@ -101,7 +101,7 @@ if(MEINPROC_NO_KARCHIVE)
     add_definitions(-DMEINPROC_NO_KARCHIVE) #we don't have saveToCache when compiling without KArchive, which is used in xslt_kde.cpp
 else ()
     set(meinproc_additional_SRCS xslt_kde.cpp)
-    set(meinproc_additional_LIBS KF5::Archive)
+    set(meinproc_additional_LIBS KF5::Archive libxml2.a libgcrypt.a libgpg-error.a)
 endif()
 
 add_executable(meinproc5 meinproc.cpp meinproc_common.cpp xslt.cpp ${meinproc_additional_SRCS} ${kdoctoolslog_core_SRCS})
EOF
echo ./source/frameworks/kxmlgui
git -C ./source/frameworks/kxmlgui checkout .
patch -p1 -d ./source/frameworks/kxmlgui <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 98efa69..e52ef51 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -36,7 +36,7 @@ add_feature_info(QCH ${BUILD_QCH} "API documentation in QCH format (for e.g. Qt
 
 # Dependencies
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus Xml Network PrintSupport)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets DBus Xml Network PrintSupport X11Extras Svg TextToSpeech)
 
 find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5ItemViews ${KF5_DEP_VERSION} REQUIRED)
@@ -47,6 +47,11 @@ find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSIqON} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Completion ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Attica ${KF5_DEP_VERSION})
 set_package_properties(KF5Attica PROPERTIES DESCRIPTION "A Qt library that implements the Open Collaboration Services API"
                        PURPOSE "Support for Get Hot New Stuff in KXMLGUI"
EOF
echo ./source/frameworks/kconfigwidgets
git -C ./source/frameworks/kconfigwidgets checkout .
patch -p1 -d ./source/frameworks/kconfigwidgets <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index a35cf3c..e75aaa4 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -17,6 +17,8 @@ ecm_qt_declare_logging_category(kconfigwidgets_SRCS HEADER kconfigwidgets_debug.
 
 qt5_add_resources(kconfigwidgets_SRCS kconfigwidgets.qrc)
 
+add_library(Qt5X11Extras)
+add_library(Qt5::X11Extras ALIAS Qt5X11Extras)
 add_library(KF5ConfigWidgets ${kconfigwidgets_SRCS})
 generate_export_header(KF5ConfigWidgets BASE_NAME KConfigWidgets)
 add_library(KF5::ConfigWidgets ALIAS KF5ConfigWidgets)
EOF
echo ./source/frameworks/kbookmarks
git -C ./source/frameworks/kbookmarks checkout .
patch -p1 -d ./source/frameworks/kbookmarks <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index df09ade..f0c9514 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -38,7 +38,7 @@ ecm_setup_version(PROJECT
 # Dependencies
 set(REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets Xml DBus)
+find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets Xml DBus Network PrintSupport Svg X11Extras TextToSpeech)
 
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
@@ -47,6 +47,17 @@ find_package(KF5ConfigWidgets ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5IconThemes ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5I18n ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5ItemViews ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Completion ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
 
 if (IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/po")
     ecm_install_po_files_as_qm(po)
EOF
echo ./source/frameworks/kemoticons
git -C ./source/frameworks/kemoticons checkout .
patch -p1 -d ./source/frameworks/kemoticons <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9765e23..cfcfb4f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,7 +13,7 @@ feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKA
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Gui DBus)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Gui DBus X11Extras)
 
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
@@ -39,6 +39,8 @@ find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5CoreAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5I18n ${KF5_DEP_VERSION})
+find_package(KF5DBusAddons ${KF5_DEP_VERSION})
 
 install(FILES ${CMAKE_CURRENT_BINARY_DIR}/kemoticons_version.h
         DESTINATION ${KDE_INSTALL_INCLUDEDIR_KF5} COMPONENT Devel )
diff --git a/src/integrationplugin/CMakeLists.txt b/src/integrationplugin/CMakeLists.txt
index d12c36f..ce66b42 100644
--- a/src/integrationplugin/CMakeLists.txt
+++ b/src/integrationplugin/CMakeLists.txt
@@ -3,7 +3,7 @@ set(KEmoticonsIntegrationPlugin_SRCS
     ktexttohtml.cpp
 )
 
-add_library(KEmoticonsIntegrationPlugin MODULE ${KEmoticonsIntegrationPlugin_SRCS})
+add_library(KEmoticonsIntegrationPlugin STATIC ${KEmoticonsIntegrationPlugin_SRCS})
 
 target_link_libraries(KEmoticonsIntegrationPlugin
     PRIVATE
EOF
echo ./source/frameworks/kcrash
git -C ./source/frameworks/kcrash checkout .
patch -p1 -d ./source/frameworks/kcrash <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6af50e4..06a185e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -12,7 +12,7 @@ feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKA
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core X11Extras)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
EOF
echo ./source/frameworks/qqc2-desktop-style
git -C ./source/frameworks/qqc2-desktop-style checkout .
patch -p1 -d ./source/frameworks/qqc2-desktop-style <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c9697df..0163b60 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -32,9 +32,9 @@ include(KDEInstallDirs)
 include(KDECMakeSettings)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Core Quick Gui Widgets QuickControls2)
+find_package(Qt5 ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE COMPONENTS Core Quick Gui Widgets QuickControls2 DBus Svg)
 
-find_package(KF5 ${KF5_DEP_VERSION} REQUIRED COMPONENTS Kirigami2)
+find_package(KF5 ${KF5_DEP_VERSION} REQUIRED COMPONENTS Kirigami2 Archive GuiAddons I18n ItemViews)
 
 find_package(KF5 ${KF5_DEP_VERSION} COMPONENTS
                 IconThemes #KIconLoader
diff --git a/kirigami-plasmadesktop-integration/CMakeLists.txt b/kirigami-plasmadesktop-integration/CMakeLists.txt
index b977752..d709ed5 100644
--- a/kirigami-plasmadesktop-integration/CMakeLists.txt
+++ b/kirigami-plasmadesktop-integration/CMakeLists.txt
@@ -6,7 +6,7 @@ set(org.kde.desktop_SRCS
 )
 
 
-add_library(org.kde.desktop MODULE ${org.kde.desktop_SRCS})
+add_library(org.kde.desktop STATIC ${org.kde.desktop_SRCS})
 
 target_link_libraries(org.kde.desktop
     PUBLIC
diff --git a/plugin/CMakeLists.txt b/plugin/CMakeLists.txt
index 90bbaea..20cbf16 100644
--- a/plugin/CMakeLists.txt
+++ b/plugin/CMakeLists.txt
@@ -14,7 +14,7 @@ set(qqc2desktopstyle_SRCS
     )
 endif()
 
-add_library(qqc2desktopstyleplugin SHARED ${qqc2desktopstyle_SRCS})
+add_library(qqc2desktopstyleplugin ${qqc2desktopstyle_SRCS})
 target_link_libraries(qqc2desktopstyleplugin Qt5::Core Qt5::Qml Qt5::Quick Qt5::Gui Qt5::Widgets KF5::Kirigami2)
 
 if(KF5ConfigWidgets_FOUND)
EOF
echo ./source/frameworks/networkmanager-qt
git -C ./source/frameworks/networkmanager-qt checkout .
patch -p1 -d ./source/frameworks/networkmanager-qt <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 7975034..1c250c7 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -128,7 +128,7 @@ set(DBUS_INTERFACE_SRCS
     dbus/wirelessdeviceinterface.cpp
 )
 
-add_library(KF5NetworkManagerQt SHARED ${NetworkManagerQt_PART_SRCS} ${NetworkManagerQt_SETTINGS_SRCS} ${DBUS_INTERFACE_SRCS})
+add_library(KF5NetworkManagerQt ${NetworkManagerQt_PART_SRCS} ${NetworkManagerQt_SETTINGS_SRCS} ${DBUS_INTERFACE_SRCS})
 generate_export_header(KF5NetworkManagerQt EXPORT_FILE_NAME ${NetworkManagerQt_BINARY_DIR}/networkmanagerqt/networkmanagerqt_export.h BASE_NAME NetworkManagerQt)
 add_library(KF5::NetworkManagerQt ALIAS KF5NetworkManagerQt)
 
EOF
echo ./source/frameworks/prison
git -C ./source/frameworks/prison checkout .
patch -p1 -d ./source/frameworks/prison <<'EOF'
diff --git a/src/quick/CMakeLists.txt b/src/quick/CMakeLists.txt
index 03cdbb5..b877293 100644
--- a/src/quick/CMakeLists.txt
+++ b/src/quick/CMakeLists.txt
@@ -1,4 +1,4 @@
-add_library(prisonquickplugin SHARED
+add_library(prisonquickplugin
     barcodequickitem.cpp
     prisonquickplugin.cpp
 )
EOF
echo ./source/frameworks/purpose
git -C ./source/frameworks/purpose checkout .
patch -p1 -d ./source/frameworks/purpose <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 44e603d..45b4936 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -7,7 +7,7 @@ find_package(ECM 5.53.0 REQUIRED NO_MODULE)
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Qml Gui DBus Widgets Network Test)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Qml Gui DBus Widgets Network Test X11Extras Svg)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -25,7 +25,7 @@ include(ECMQtDeclareLoggingCategory)
 set(KF5_VERSION "5.53.0") # handled by release scripts
 set(KF5_DEP_VERSION "5.53.0") # handled by release scripts
 
-find_package(KF5 ${KF5_DEP_VERSION} REQUIRED COMPONENTS CoreAddons I18n Config)
+find_package(KF5 ${KF5_DEP_VERSION} REQUIRED COMPONENTS CoreAddons I18n Config DBusAddons Crash WindowSystem IconThemes Archive WidgetsAddons ItemViews ConfigWidgets GuiAddons)
 
 # Debian is a special snow flake and uses nodejs as binary name
 # https://lists.debian.org/debian-devel-announce/2012/07/msg00002.html
EOF
echo ./source/frameworks/kauth
git -C ./source/frameworks/kauth checkout .
patch -p1 -d ./source/frameworks/kauth <<'EOF'
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 9850acd..ed55a72 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -104,7 +104,7 @@ endif ()
 if (NOT "${KAUTH_BACKEND_NAME}" STREQUAL "FAKE" AND TARGET Qt5::Widgets)
     set(KAUTH_BACKEND_SRCS ${KAUTH_BACKEND_SRCS})
     # KAuth::AuthBackend is not exported
-    add_library(kauth_backend_plugin MODULE ${KAUTH_BACKEND_SRCS} AuthBackend.cpp ${kauthdebug_SRCS})
+    add_library(kauth_backend_plugin ${KAUTH_BACKEND_SRCS} AuthBackend.cpp ${kauthdebug_SRCS})
     target_link_libraries(kauth_backend_plugin PRIVATE ${KAUTH_BACKEND_LIBS})
     set_target_properties(kauth_backend_plugin PROPERTIES PREFIX "")
 
@@ -119,7 +119,7 @@ endif ()
 
 if (NOT "${KAUTH_HELPER_BACKEND_NAME}" STREQUAL "FAKE" AND TARGET Qt5::Widgets)
     # KAuth::HelperProxy is not exported
-    add_library(kauth_helper_plugin MODULE ${KAUTH_HELPER_BACKEND_SRCS} HelperProxy.cpp ${kauthdebug_SRCS})
+    add_library(kauth_helper_plugin ${KAUTH_HELPER_BACKEND_SRCS} HelperProxy.cpp ${kauthdebug_SRCS})
     target_link_libraries(kauth_helper_plugin PRIVATE ${KAUTH_HELPER_BACKEND_LIBS})
     set_target_properties(kauth_helper_plugin PROPERTIES PREFIX "")
     install(TARGETS kauth_helper_plugin
EOF
echo ./source/frameworks/kcoreaddons
git -C ./source/frameworks/kcoreaddons checkout .
patch -p1 -d ./source/frameworks/kcoreaddons <<'EOF'
diff --git a/KF5CoreAddonsMacros.cmake b/KF5CoreAddonsMacros.cmake
index e762384..cd390cf 100644
--- a/KF5CoreAddonsMacros.cmake
+++ b/KF5CoreAddonsMacros.cmake
@@ -121,7 +121,7 @@ function(kcoreaddons_add_plugin plugin)
     endif()
     get_filename_component(json "${KCA_ADD_PLUGIN_JSON}" REALPATH)
 
-    add_library(${plugin} MODULE ${KCA_ADD_PLUGIN_SOURCES})
+    add_library(${plugin} STATIC ${KCA_ADD_PLUGIN_SOURCES})
     set_property(TARGET ${plugin} APPEND PROPERTY AUTOGEN_TARGET_DEPENDS ${json})
     # If find_package(ECM 5.38) or higher is called, output the plugin in a INSTALL_NAMESPACE subfolder.
     # See https://community.kde.org/Guidelines_and_HOWTOs/Making_apps_run_uninstalled
diff --git a/autotests/CMakeLists.txt b/autotests/CMakeLists.txt
index 0cf99e6..411825b 100644
--- a/autotests/CMakeLists.txt
+++ b/autotests/CMakeLists.txt
@@ -9,7 +9,7 @@ if(NOT Qt5Test_FOUND)
 endif()
 
 macro(build_plugin pname)
-    add_library(${pname} MODULE ${ARGN})
+    add_library(${pname} STATIC ${ARGN})
     ecm_mark_as_test(${pname})
     target_link_libraries(${pname} KF5::CoreAddons)
 endmacro()
diff --git a/src/lib/plugin/kpluginfactory.h b/src/lib/plugin/kpluginfactory.h
index 811b07f..e721a15 100644
--- a/src/lib/plugin/kpluginfactory.h
+++ b/src/lib/plugin/kpluginfactory.h
@@ -482,6 +482,7 @@ protected:
      * new T(QObject *parent, const QVariantList &args)
      * \endcode
      */
+public:
     template<class T>
     void registerPlugin(const QString &keyword = QString(), CreateInstanceFunction instanceFunction
                         = InheritanceChecker<T>().createInstanceFunction(reinterpret_cast<T *>(0)))
@@ -490,7 +491,7 @@ protected:
     }
 
     KPluginFactoryPrivate *const d_ptr;
-
+protected:
     /**
      * @deprecated since 4.0 use create<T>(QObject *parent, const QVariantList &args)
      */
EOF
echo ./source/frameworks/kross
git -C ./source/frameworks/kross checkout .
patch -p1 -d ./source/frameworks/kross <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 55cd594..1b2d88b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -30,7 +30,7 @@ ecm_setup_version(PROJECT VARIABLE_PREFIX KROSS
                         SOVERSION 5)
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Script Xml Widgets UiTools)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Script Xml Widgets UiTools Concurrent PrintSupport Svg TextToSpeech X11Extras)
 
 
 find_package(Qt5Test ${REQUIRED_QT_VERSION} CONFIG QUIET)
@@ -52,6 +52,13 @@ find_package(KF5Parts ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5DocTools ${KF5_DEP_VERSION})
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 remove_definitions(-DQT_NO_CAST_FROM_ASCII)
 
diff --git a/src/modules/CMakeLists.txt b/src/modules/CMakeLists.txt
index 48e2c02..da56a63 100644
--- a/src/modules/CMakeLists.txt
+++ b/src/modules/CMakeLists.txt
@@ -3,7 +3,7 @@ if( Qt5UiTools_FOUND )
 	# the forms module
 
 	set(krossmoduleforms_SRCS form.cpp)
-    add_library(krossmoduleforms MODULE ${krossmoduleforms_SRCS})
+	add_library(krossmoduleforms STATIC ${krossmoduleforms_SRCS})
 
     target_link_libraries(krossmoduleforms
        Qt5::UiTools
@@ -20,7 +20,7 @@ endif()
 # the kdetranslation module
 
 set(krossmodulekdetranslation_SRCS translation.cpp)
-add_library(krossmodulekdetranslation MODULE ${krossmodulekdetranslation_SRCS})
+add_library(krossmodulekdetranslation STATIC ${krossmodulekdetranslation_SRCS})
 
 target_link_libraries(krossmodulekdetranslation
    KF5::Parts
diff --git a/src/qts-interpreter/CMakeLists.txt b/src/qts-interpreter/CMakeLists.txt
index 666789b..ba66a7c 100644
--- a/src/qts-interpreter/CMakeLists.txt
+++ b/src/qts-interpreter/CMakeLists.txt
@@ -5,7 +5,7 @@ ecm_qt_declare_logging_category(
     IDENTIFIER KROSS_QTSCRIPT_LOG
     CATEGORY_NAME org.kde.kross.qtscript
 )
-add_library(krossqts MODULE ${krossqts_PART_SRCS})
+add_library(krossqts STATIC ${krossqts_PART_SRCS})
 target_link_libraries(krossqts
     KF5::KrossCore
     Qt5::Script
diff --git a/src/qts/CMakeLists.txt b/src/qts/CMakeLists.txt
index 93d3bd9..f97106b 100644
--- a/src/qts/CMakeLists.txt
+++ b/src/qts/CMakeLists.txt
@@ -5,7 +5,7 @@ ecm_qt_declare_logging_category(
     IDENTIFIER KROSS_QTS_PLUGIN_LOG
     CATEGORY_NAME org.kde.kross.qts_plugin
 )
-add_library(krossqtsplugin MODULE ${krossqtsplugin_LIB_SRCS})
+add_library(krossqtsplugin STATIC ${krossqtsplugin_LIB_SRCS})
 target_link_libraries(krossqtsplugin
     KF5::I18n
     KF5::KrossCore
EOF
echo ./source/frameworks/kwayland
git -C ./source/frameworks/kwayland checkout .
patch -p1 -d ./source/frameworks/kwayland <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7f3155f..157d7d5 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -41,6 +41,7 @@ set_package_properties(Wayland PROPERTIES
 find_package(WaylandScanner)
 
 find_package(EGL)
+message("EGL_LIBRARIES ${EGL_LIBRARIES}")
 set_package_properties(EGL PROPERTIES TYPE REQUIRED)
 
 include(KDEInstallDirs)
diff --git a/src/client/CMakeLists.txt b/src/client/CMakeLists.txt
index b191390..cb0d734 100644
--- a/src/client/CMakeLists.txt
+++ b/src/client/CMakeLists.txt
@@ -218,7 +218,7 @@ ecm_add_wayland_client_protocol(CLIENT_LIB_SRCS
     BASENAME remote-access
 )
 
-add_library(KF5WaylandClient ${CLIENT_LIB_SRCS})
+add_library(KF5WaylandClient STATIC ${CLIENT_LIB_SRCS})
 generate_export_header(KF5WaylandClient
     BASE_NAME
         KWaylandClient
diff --git a/src/server/CMakeLists.txt b/src/server/CMakeLists.txt
index 8e0cc9f..9cb9298 100644
--- a/src/server/CMakeLists.txt
+++ b/src/server/CMakeLists.txt
@@ -252,7 +252,7 @@ set(SERVER_GENERATED_SRCS
 
 set_source_files_properties(${SERVER_GENERATED_SRCS} PROPERTIES SKIP_AUTOMOC ON)
 
-add_library(KF5WaylandServer ${SERVER_LIB_SRCS})
+add_library(KF5WaylandServer STATIC ${SERVER_LIB_SRCS})
 generate_export_header(KF5WaylandServer
     BASE_NAME
         KWaylandServer
EOF
echo ./source/frameworks/kparts
git -C ./source/frameworks/kparts checkout .
patch -p1 -d ./source/frameworks/kparts <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index ba80366..f61c33a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,7 +13,7 @@ feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKA
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 set(REQUIRED_QT_VERSION 5.9.0)
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Widgets Xml)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Core Widgets Xml X11Extras Concurrent Svg PrintSupport TextToSpeech)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -42,6 +42,13 @@ find_package(KF5Service ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5TextWidgets ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5XmlGui ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Attica ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 remove_definitions(-DQT_NO_CAST_FROM_ASCII)
 remove_definitions(-DQT_NO_CAST_FROM_BYTEARRAY)
diff --git a/templates/kpartsapp/src/part/CMakeLists.txt b/templates/kpartsapp/src/part/CMakeLists.txt
index 006bd84..81a933d 100644
--- a/templates/kpartsapp/src/part/CMakeLists.txt
+++ b/templates/kpartsapp/src/part/CMakeLists.txt
@@ -4,7 +4,7 @@ set(%{APPNAMELC}_PART_SRCS
    %{APPNAMELC}part.cpp
 )
 
-add_library(%{APPNAMELC}part MODULE ${%{APPNAMELC}_PART_SRCS})
+add_library(%{APPNAMELC}part STATIC ${%{APPNAMELC}_PART_SRCS})
 
 target_link_libraries(%{APPNAMELC}part
     KF5::I18n
diff --git a/tests/CMakeLists.txt b/tests/CMakeLists.txt
index f8c69e6..cf2fc18 100644
--- a/tests/CMakeLists.txt
+++ b/tests/CMakeLists.txt
@@ -21,13 +21,13 @@ target_link_libraries(normalktmtest ${PARTS_TEST_LIBRARY_DEPENDENCIES})
 
 ########### next target ###############
 
-add_library(spellcheckplugin MODULE plugin_spellcheck.cpp)
+add_library(spellcheckplugin STATIC plugin_spellcheck.cpp)
 target_link_libraries(spellcheckplugin ${PARTS_TEST_LIBRARY_DEPENDENCIES} )
 install(TARGETS spellcheckplugin  DESTINATION ${KDE_INSTALL_PLUGINDIR} )
 
 ########### next target ###############
 
-add_library(notepadpart MODULE notepad.cpp)
+add_library(notepadpart STATIC notepad.cpp)
 target_link_libraries(notepadpart ${PARTS_TEST_LIBRARY_DEPENDENCIES})
 install(TARGETS notepadpart  DESTINATION ${KDE_INSTALL_PLUGINDIR} )
 
EOF
echo ./source/frameworks/kdeclarative
git -C ./source/frameworks/kdeclarative checkout .
patch -p1 -d ./source/frameworks/kdeclarative <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index dffd476..30186ea 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -14,7 +14,7 @@ set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake ${ECM_MODULE_PATH} ${ECM
 
 set(REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Qml Quick Gui)
+find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Qml Quick Gui Concurrent X11Extras Svg)
 include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
 include(KDECMakeSettings)
@@ -28,6 +28,9 @@ find_package(KF5WindowSystem ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5GlobalAccel ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5GuiAddons ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5Package ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Archive ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} REQUIRED)
+find_package(KF5Crash ${KF5_DEP_VERSION} REQUIRED)
 
 #########################################################################
 
diff --git a/src/calendarevents/CMakeLists.txt b/src/calendarevents/CMakeLists.txt
index a4ce72a..41e48ff 100644
--- a/src/calendarevents/CMakeLists.txt
+++ b/src/calendarevents/CMakeLists.txt
@@ -3,7 +3,7 @@ set(calendar-integration_SRCS
     eventdata_p.cpp
 )
 
-add_library(KF5CalendarEvents SHARED ${calendar-integration_SRCS})
+add_library(KF5CalendarEvents ${calendar-integration_SRCS})
 generate_export_header(KF5CalendarEvents BASE_NAME CalendarEvents)
 add_library(KF5::CalendarEvents ALIAS KF5CalendarEvents)
 
diff --git a/src/qmlcontrols/draganddrop/CMakeLists.txt b/src/qmlcontrols/draganddrop/CMakeLists.txt
index e8127e4..e649c4f 100644
--- a/src/qmlcontrols/draganddrop/CMakeLists.txt
+++ b/src/qmlcontrols/draganddrop/CMakeLists.txt
@@ -9,7 +9,7 @@ set(declarativedragdrop_SRCS
     MimeDataWrapper.cpp
 )
 
-add_library(draganddropplugin SHARED ${declarativedragdrop_SRCS})
+add_library(draganddropplugin ${declarativedragdrop_SRCS})
 target_link_libraries(draganddropplugin
         Qt5::Core
         Qt5::Quick
diff --git a/src/qmlcontrols/kcmcontrols/CMakeLists.txt b/src/qmlcontrols/kcmcontrols/CMakeLists.txt
index 895b4c6..b40601e 100644
--- a/src/qmlcontrols/kcmcontrols/CMakeLists.txt
+++ b/src/qmlcontrols/kcmcontrols/CMakeLists.txt
@@ -4,7 +4,7 @@ set(declarativedragdrop_SRCS
     kcmcontrolsplugin.cpp
 )
 
-add_library(kcmcontrolsplugin SHARED ${declarativedragdrop_SRCS})
+add_library(kcmcontrolsplugin ${declarativedragdrop_SRCS})
 target_link_libraries(kcmcontrolsplugin
         Qt5::Core
         Qt5::Quick
diff --git a/src/qmlcontrols/kconfig/CMakeLists.txt b/src/qmlcontrols/kconfig/CMakeLists.txt
index 59a68b2..7365810 100644
--- a/src/qmlcontrols/kconfig/CMakeLists.txt
+++ b/src/qmlcontrols/kconfig/CMakeLists.txt
@@ -5,7 +5,7 @@ set(kconfigplugin_SRCS
     kauthorizedproxy.cpp
     )
 
-add_library(kconfigplugin SHARED ${kconfigplugin_SRCS})
+add_library(kconfigplugin ${kconfigplugin_SRCS})
 target_link_libraries(kconfigplugin
         Qt5::Core
         Qt5::Qml
diff --git a/src/qmlcontrols/kcoreaddons/CMakeLists.txt b/src/qmlcontrols/kcoreaddons/CMakeLists.txt
index 3f77f2d..3c27e3b 100644
--- a/src/qmlcontrols/kcoreaddons/CMakeLists.txt
+++ b/src/qmlcontrols/kcoreaddons/CMakeLists.txt
@@ -6,7 +6,7 @@ set(kcoreaddonsplugin_SRCS
     kuserproxy.cpp
     )
 
-add_library(kcoreaddonsplugin SHARED ${kcoreaddonsplugin_SRCS})
+add_library(kcoreaddonsplugin ${kcoreaddonsplugin_SRCS})
 target_link_libraries(kcoreaddonsplugin
         Qt5::Core
         Qt5::Quick
diff --git a/src/qmlcontrols/kioplugin/CMakeLists.txt b/src/qmlcontrols/kioplugin/CMakeLists.txt
index 7b258e0..898c79f 100644
--- a/src/qmlcontrols/kioplugin/CMakeLists.txt
+++ b/src/qmlcontrols/kioplugin/CMakeLists.txt
@@ -5,7 +5,7 @@ set(kioplugin_SRCS
     krunproxy.cpp
     )
 
-add_library(kio SHARED ${kioplugin_SRCS})
+add_library(kio ${kioplugin_SRCS})
 target_link_libraries(kio
         Qt5::Core
         Qt5::Qml
diff --git a/src/qmlcontrols/kquickcontrols/private/CMakeLists.txt b/src/qmlcontrols/kquickcontrols/private/CMakeLists.txt
index da355c1..b624d1e 100644
--- a/src/qmlcontrols/kquickcontrols/private/CMakeLists.txt
+++ b/src/qmlcontrols/kquickcontrols/private/CMakeLists.txt
@@ -6,7 +6,7 @@ set(kquickcontrolsprivate_SRCS
     translationcontext.cpp
 )
 
-add_library(kquickcontrolsprivateplugin SHARED ${kquickcontrolsprivate_SRCS})
+add_library(kquickcontrolsprivateplugin ${kquickcontrolsprivate_SRCS})
 
 target_link_libraries(kquickcontrolsprivateplugin
         Qt5::Core
diff --git a/src/qmlcontrols/kquickcontrolsaddons/CMakeLists.txt b/src/qmlcontrols/kquickcontrolsaddons/CMakeLists.txt
index f12474d..84c1a68 100644
--- a/src/qmlcontrols/kquickcontrolsaddons/CMakeLists.txt
+++ b/src/qmlcontrols/kquickcontrolsaddons/CMakeLists.txt
@@ -22,7 +22,7 @@ if (HAVE_EPOXY)
     include_directories(${epoxy_INCLUDE_DIR})
 endif()
 
-add_library(kquickcontrolsaddonsplugin SHARED ${kquickcontrolsaddons_SRCS})
+add_library(kquickcontrolsaddonsplugin ${kquickcontrolsaddons_SRCS})
 
 target_link_libraries(kquickcontrolsaddonsplugin
         Qt5::Core
diff --git a/src/qmlcontrols/kwindowsystemplugin/CMakeLists.txt b/src/qmlcontrols/kwindowsystemplugin/CMakeLists.txt
index ce0ea74..9c3892a 100644
--- a/src/qmlcontrols/kwindowsystemplugin/CMakeLists.txt
+++ b/src/qmlcontrols/kwindowsystemplugin/CMakeLists.txt
@@ -5,7 +5,7 @@ set(kwindowsystemplugin_SRCS
     kwindowsystemproxy.cpp
     )
 
-add_library(kwindowsystem SHARED ${kwindowsystemplugin_SRCS})
+add_library(kwindowsystem ${kwindowsystemplugin_SRCS})
 target_link_libraries(kwindowsystem
         Qt5::Core
         Qt5::Qml
EOF
echo ./source/frameworks/kcompletion
git -C ./source/frameworks/kcompletion checkout .
patch -p1 -d ./source/frameworks/kcompletion <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8920c20..9b95741 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -32,7 +32,7 @@ ecm_setup_version(PROJECT VARIABLE_PREFIX KCOMPLETION
 # Dependencies
 set(REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets)
+find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED Widgets DBus)
 
 find_package(KF5Config ${KF5_DEP_VERSION} REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} REQUIRED)
EOF
echo ./source/frameworks/kpeople
git -C ./source/frameworks/kpeople checkout .
patch -p1 -d ./source/frameworks/kpeople <<'EOF'
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8aa5b88..27d28ec 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,13 +13,14 @@ set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 set(REQUIRED_QT_VERSION 5.9.0)
 
-find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Gui Sql DBus Widgets Qml)
+find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Gui Sql DBus Widgets Qml X11Extras)
 
 find_package(KF5CoreAddons ${KF5_DEP_VERSION} CONFIG REQUIRED)
 find_package(KF5WidgetsAddons ${KF5_DEP_VERSION} CONFIG REQUIRED)
 find_package(KF5I18n ${KF5_DEP_VERSION} CONFIG REQUIRED)
 find_package(KF5ItemViews ${KF5_DEP_VERSION} CONFIG REQUIRED)
 find_package(KF5Service ${KF5_DEP_VERSION} CONFIG REQUIRED)
+find_package(KF5DBusAddons ${KF5_DEP_VERSION} CONFIG REQUIRED)
 
 include(ECMSetupVersion)
 include(ECMGenerateHeaders)
diff --git a/src/declarative/CMakeLists.txt b/src/declarative/CMakeLists.txt
index 6558616..492e3eb 100644
--- a/src/declarative/CMakeLists.txt
+++ b/src/declarative/CMakeLists.txt
@@ -1,4 +1,4 @@
-add_library(KF5PeopleDeclarative SHARED
+add_library(KF5PeopleDeclarative
                     declarativepersondata.cpp
                     personactionsmodel.cpp
                     peopleqmlplugin.cpp)
diff --git a/src/plugins/akonadi/CMakeLists.txt b/src/plugins/akonadi/CMakeLists.txt
index 23615bc..7a6d661 100644
--- a/src/plugins/akonadi/CMakeLists.txt
+++ b/src/plugins/akonadi/CMakeLists.txt
@@ -1,6 +1,6 @@
 ecm_qt_declare_logging_category(KF5People_akonadi_debug_SRCS HEADER kpeople_akonadi_plugin_debug.h IDENTIFIER KPEOPLE_AKONADI_PLUGIN_LOG CATEGORY_NAME kf5.kpeople.plugin.akonadi)
 
-add_library(akonadi_kpeople_plugin MODULE akonadidatasource.cpp ${KF5People_akonadi_debug_SRCS})
+add_library(akonadi_kpeople_plugin STATIC akonadidatasource.cpp ${KF5People_akonadi_debug_SRCS})
 
 target_link_libraries (akonadi_kpeople_plugin
     ${KDEPIMLIBS_AKONADI_LIBS}
diff --git a/src/widgets/CMakeLists.txt b/src/widgets/CMakeLists.txt
index 66b1a5a..210f113 100644
--- a/src/widgets/CMakeLists.txt
+++ b/src/widgets/CMakeLists.txt
@@ -15,7 +15,7 @@ ecm_qt_declare_logging_category(kpeople_widgets_SRCS HEADER kpeople_widgets_debu
 
 qt5_wrap_ui (kpeople_widgets_SRCS person-details-presentation.ui)
 
-add_library (KF5PeopleWidgets SHARED ${kpeople_widgets_SRCS} )
+add_library (KF5PeopleWidgets ${kpeople_widgets_SRCS} )
 add_library (KF5::PeopleWidgets ALIAS KF5PeopleWidgets)
 
 target_link_libraries (KF5PeopleWidgets
diff --git a/src/widgets/plugins/CMakeLists.txt b/src/widgets/plugins/CMakeLists.txt
index e189aff..f356854 100644
--- a/src/widgets/plugins/CMakeLists.txt
+++ b/src/widgets/plugins/CMakeLists.txt
@@ -1,21 +1,21 @@
 include_directories(..)
 
 # Email plugin
-# add_library(emaildetailswidgetplugin MODULE emaildetailswidget.cpp)
+# add_library(emaildetailswidgetplugin STATIC emaildetailswidget.cpp)
 # target_link_libraries(emaildetailswidgetplugin Qt5::Core Qt5::Gui ${KDE4_KDECORE_LIBRARY} KF5::People KF5::PeopleWidgets)
 #
 # install(TARGETS emaildetailswidgetplugin DESTINATION ${PLUGIN_INSTALL_DIR})
 # install(FILES emaildetailswidgetplugin.desktop DESTINATION ${SERVICES_INSTALL_DIR})
 #
 # #  Merge Plugin
-# add_library(mergecontactswidgetplugin MODULE mergecontactswidget.cpp personpresentationwidget.cpp)
+# add_library(mergecontactswidgetplugin STATIC mergecontactswidget.cpp personpresentationwidget.cpp)
 # target_link_libraries(mergecontactswidgetplugin Qt5::Core Qt5::Gui ${KDE4_KDECORE_LIBRARY} KF5::People KF5::PeopleWidgets)
 #
 # install(TARGETS mergecontactswidgetplugin DESTINATION ${PLUGIN_INSTALL_DIR})
 # install(FILES mergecontactswidgetplugin.desktop DESTINATION ${SERVICES_INSTALL_DIR})
 #
 # # Phone plugin
-# add_library(phonedetailswidgetplugin MODULE phonedetailswidget.cpp)
+# add_library(phonedetailswidgetplugin STATIC phonedetailswidget.cpp)
 # target_link_libraries(phonedetailswidgetplugin Qt5::Core Qt5::Gui ${KDE4_KDECORE_LIBRARY} KF5::People KF5::PeopleWidgets)
 #
 # install(TARGETS phonedetailswidgetplugin DESTINATION ${PLUGIN_INSTALL_DIR})
EOF
echo ./source/frameworks/kholidays
git -C ./source/frameworks/kholidays checkout .
patch -p1 -d ./source/frameworks/kholidays <<'EOF'
diff --git a/src/declarative/CMakeLists.txt b/src/declarative/CMakeLists.txt
index 825bbb9..e72c2b1 100644
--- a/src/declarative/CMakeLists.txt
+++ b/src/declarative/CMakeLists.txt
@@ -1,4 +1,4 @@
-add_library(kholidaysdeclarativeplugin SHARED kholidaysdeclarativeplugin.cpp holidayregionsmodel.cpp)
+add_library(kholidaysdeclarativeplugin kholidaysdeclarativeplugin.cpp holidayregionsmodel.cpp)
 
 target_link_libraries(kholidaysdeclarativeplugin
   Qt5::Qml
EOF
