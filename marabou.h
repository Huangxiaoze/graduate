#ifndef MARABOU_H
#define MARABOU_H

#include "project.h"
#include "marabouverifythread.h"

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
    void SIGNAL_verify_by_marabou(QJsonObject);
public slots:
    void on_import_network();
    void on_run_abstract();
    void on_as_slider_valueChange(int);
    void on_rs_slider_valudeChange(int);
    void on_ar_status(int);
    void on_verify_without_ar();
    void on_verify_with_ar();
private:
    QJsonObject getParameter();
    void connect_S_L();
    Ui::Marabou *ui;
    Project *project = nullptr;
};

#endif // MARABOU_H
