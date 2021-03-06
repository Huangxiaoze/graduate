#include <Python.h>
#include "mainui.h"
#include "init_python.h"

#include <QApplication>
#include <QDir>
#include <QMessageBox>
#include <QDebug>
#include <QResource>
#include <QSplashScreen>
#include <QPixmap>

Python python("");
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QSplashScreen splash(QPixmap(":/resources/loading.gif"));
    splash.showMessage("Loading...");
    splash.show();
    Py_Initialize();
    python.importModule("core.nnet.read_nnet");
    python.importModule("core.prodeep.prodeep");
    python.importFunc("core.nnet.read_nnet", "network_from_nnet_file");
    python.importFunc("core.nnet.read_nnet", "get_network_in_json_str");
    python.importFunc("core.prodeep.prodeep", "abstract");
    python.importFunc("core.prodeep.prodeep", "verify_without_ar");
    python.importFunc("core.prodeep.prodeep", "verify_with_ar");
    python.importFunc("core.prodeep.prodeep", "dumpRlv");
    python.importFunc("core.prodeep.prodeep", "planet_without_ar");
    python.importFunc("core.prodeep.prodeep", "planet_with_ar");
    qDebug() << "=========Finish init Python environment=========" << endl;

    QDir tmpPath = QDir::tempPath();


    if(!tmpPath.cd("Qt")){
        tmpPath.mkdir("Qt");
        tmpPath.cd("Qt");
    }
    if(!tmpPath.cd("lib")){
        tmpPath.mkdir("lib");
        tmpPath.cd("lib");
    }
     QFileInfo info(tmpPath.absoluteFilePath("deepsymbol"));
     if(!info.isFile()){
         bool copyResult = false;

#if defined(Q_OS_LINUX)
        copyResult= QFile::copy(":/resources/deepsymbol_linux",info.absoluteFilePath());
#elif defined(Q_OS_MAC)
         copyResult= QFile::copy(":/resources/deepsymbol_mac",info.absoluteFilePath());
#elif defined(Q_OS_WIN32)
         copyResult= QFile::copy(":/resources/deepsymbol_windows",info.absoluteFilePath());
#else
        qDebug() << "Unsupported arctecture";
        return -7;
#endif
        if(!copyResult)
        {
            //QMessageBox::warning(this, "Worning", "Failed to access TemporaryFile!");
            qDebug() << "Failed to access TemporaryFile!";
            return -7;
        }
     }
    /*
    QDir dir(qApp->applicationDirPath());
    if(!dir.cd("lib")){
        QMessageBox::warning(&w, "Worning", "does not have \".\\lib\" directory!");
        return -7;
    }
    QFileInfo info(dir.absoluteFilePath("epmc-qmc.jar"));
    if(!info.isFile()){
        QMessageBox::warning(&w, "Worning", "lack of \"epmc-qmc.jar\" in \"\\lib\"!");
        return -7;
    }*/

    MainUI w;
    splash.finish(&w);
    w.showMaximized();

    int ret = a.exec();
    Py_Finalize();
    qDebug() << "exit......." << endl;
    return ret;
}
