#include "marabou.h"
#include "ui_marabou.h"
#include <QFileDialog>
#include <QMessageBox>
#include <iostream>
#include <QDebug>
#include <QJsonObject>

Marabou::Marabou(Project *project, QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Marabou)
{
    ui->setupUi(this);
    this->project = project;

    qDebug() << "Marabou" << endl;
    connect_S_L();
}

Marabou::~Marabou()
{
    delete ui;
}

void Marabou::connect_S_L() {
    connect(this->ui->importNetwork, SIGNAL(clicked()), this, SLOT(on_import_network()));
    connect(this->ui->run_abstract, SIGNAL(clicked()), this, SLOT(on_run_abstract()));
    connect(this->ui->abstraction_sequence_slider, SIGNAL(valueChanged(int)), this, SLOT(on_as_slider_valueChange(int)));
    connect(this->ui->ar_checkbox, SIGNAL(stateChanged(int)), this, SLOT(on_ar_status(int)));
    connect(this->ui->verify_without_ar, SIGNAL(clicked()), this, SLOT(on_verify_without_ar()));
    connect(this->ui->verify_with_ar, SIGNAL(clicked()), this, SLOT(on_verify_with_ar()));
    connect(this->ui->refinement_sequence_slider, SIGNAL(valueChanged(int)), this, SLOT(on_rs_slider_valueChange(int)));
}

void Marabou::on_ar_status(int s) {
    qDebug() << "changeStatus " << this->ui->ar_checkbox->isChecked() << endl;
    bool checked = this->ui->ar_checkbox->isChecked();
    this->ui->run_abstract->setDisabled(!checked);
    this->ui->refine_next->setDisabled(!checked);
    this->ui->refine_finish->setDisabled(!checked);
}

void Marabou::on_import_network() {
    qDebug() << "Marabou" << "on_import_network" << endl;
    QString file = QFileDialog::getOpenFileName(this,tr("Choose Network File"), this->project->getPath());
    if (!file.isEmpty()) {
        this->ui->network_lineEdit->setText(file);
        emit SIGNAL_import_network(file);
    }
}

void Marabou::on_run_abstract() {
    QJsonObject parameter = getParameter();
    QString file = parameter.value("filepath").toString();
    if (file.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select Network file.");
        return;
    }
    emit SIGNAL_run_abstract(parameter);
}

void Marabou::on_as_slider_valueChange(int value) {
    this->ui->as_value->setText(QString("%1").arg(value));
}

void Marabou::on_rs_slider_valudeChange(int value) {
    this->ui->rs_value->setText(QString("%1").arg(value));
}

void Marabou::on_verify_without_ar() {
    QJsonObject parameter = getParameter();
    QString file = parameter.value("filepath").toString();
    if (file.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select Network file.");
        return;
    }
    parameter["verify_mode"] = VERIFY_WITHOUT_AR;
    emit SIGNAL_verify_by_marabou(parameter);
}

void Marabou::on_verify_with_ar() {
    QJsonObject parameter = getParameter();
    QString file = parameter.value("filepath").toString();
    if (file.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select Network file.");
        return;
    }
    parameter["verify_mode"] = VERIFY_WITH_AR;
    emit SIGNAL_verify_by_marabou(parameter);
}

QJsonObject Marabou::getParameter() {
    QString file = this->ui->network_lineEdit->text();
    QString abstract_type = this->ui->abstract_type_combobox->currentText();
    QString refinement_type = this->ui->refinement_type_combobox->currentText();
    QString as = QString("%1").arg(this->ui->abstraction_sequence_slider->value());
    QString rs = this->ui->rs_value->text();
    QString property = this->ui->property_combobox->currentText();
    QJsonObject parameter;
    parameter["filepath"] = file;
    parameter["abstract_type"] = abstract_type;
    parameter["abstraction_sequence"] = as;
    parameter["refinement_sequence"] = rs;
    parameter["property_id"] = property;
    parameter["refinement_type"] = refinement_type;
    return parameter;
}

