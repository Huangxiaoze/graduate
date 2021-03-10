#ifndef MARABOU_H
#define MARABOU_H

#include "project.h"
#include <QWidget>
#include <QString>
#include <QJsonObject>

namespace Ui {
class Marabou;
}

class Marabou : public QWidget
{
    Q_OBJECT

public:
    explicit Marabou(Project* project, QWidget *parent = nullptr);
    ~Marabou();
signals:
    void SIGNAL_import_network(QString);
    void SIGNAL_run_abstract(QJsonObject);
public slots:
    void on_import_network();
    void on_run_abstract();
    void on_as_slider_valueChange(int);
    void on_ar_status(int);
private:
    void connect_S_L();
    Ui::Marabou *ui;
    Project *project = nullptr;
};

#endif // MARABOU_H
