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
}

void Marabou::on_import_network() {
    qDebug() << "Marabou" << "on_import_network" << endl;
    QString file = QFileDialog::getOpenFileName(this,tr("Choose Network File"), this->project->getPath());
    if (!file.isEmpty()) {
        this->ui->network_lineEdit->setText(file);
    }
    emit SIGNAL_import_network(file);
}

void Marabou::on_run_abstract() {
    QString file = this->ui->network_lineEdit->text();
    QString abstract_type = this->ui->abstract_type_combobox->currentText();
    QString as = QString("%1").arg(this->ui->abstraction_sequence_slider->value());
    QString property = this->ui->property_combobox->currentText();
    if (file.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select Network file.");
        return;
    }
    QJsonObject parameter;
    parameter["filepath"] = file;
    parameter["abstract_type"] = abstract_type;
    parameter["abstraction_sequence"] = as;
    parameter["property_id"] = property;
    emit SIGNAL_run_abstract(parameter);
}

void Marabou::on_as_slider_valueChange(int value) {
    this->ui->as_value->setText(QString("%1").arg(value));
}
