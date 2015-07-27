/***************************************************************************
 *   Copyright (C) 2006-2015 by Artur Kozioł                               *
 *   artkoz78@gmail.com                                                    *
 *                                                                         *
 *   This file is part of EdytorNC.                                        *
 *                                                                         *
 *   EdytorNC is free software; you can redistribute it and/or modify      *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/



#include "serialportconfigdialog.h"


static const char blankString[] = QT_TRANSLATE_NOOP("SettingsDialog", "N/A");


SerialPortConfigDialog::SerialPortConfigDialog(QWidget *parent, QString confName, Qt::WindowFlags f) : QDialog(parent, f)
{
   setupUi(this);
   setAttribute(Qt::WA_DeleteOnClose);
   setWindowTitle(tr("Serial port configuration"));
   setModal(true);

   configName = confName;

   baudGroup = new QButtonGroup(this);
   baudGroup->setExclusive(true);
   baudGroup->addButton(b3CheckBox, QSerialPort::Baud1200);
   baudGroup->addButton(b4CheckBox, QSerialPort::Baud2400);
   baudGroup->addButton(b5CheckBox, QSerialPort::Baud4800);
   baudGroup->addButton(b6CheckBox, QSerialPort::Baud9600);
   baudGroup->addButton(b7CheckBox, QSerialPort::Baud19200);
   baudGroup->addButton(b8CheckBox, QSerialPort::Baud38400);
   baudGroup->addButton(b9CheckBox, QSerialPort::Baud57600);
   baudGroup->addButton(b11CheckBox, QSerialPort::Baud115200);



   dataBitsGroup = new QButtonGroup(this);
   dataBitsGroup->setExclusive(true);
   dataBitsGroup->addButton(d1CheckBox, QSerialPort::Data5);
   dataBitsGroup->addButton(d2CheckBox, QSerialPort::Data6);
   dataBitsGroup->addButton(d3CheckBox, QSerialPort::Data7);
   dataBitsGroup->addButton(d4CheckBox, QSerialPort::Data8);


   stopBitsGroup = new QButtonGroup(this);
   stopBitsGroup->setExclusive(true);
   stopBitsGroup->addButton(s1CheckBox, QSerialPort::OneStop);
   stopBitsGroup->addButton(s2CheckBox, QSerialPort::TwoStop);


   parityGroup = new QButtonGroup(this);
   parityGroup->setExclusive(true);
   parityGroup->addButton(p1CheckBox, QSerialPort::NoParity);
   parityGroup->addButton(p2CheckBox, QSerialPort::OddParity);
   parityGroup->addButton(p3CheckBox, QSerialPort::EvenParity);



   flowCtlGroup = new QButtonGroup(this);
   flowCtlGroup->setExclusive(true);
   flowCtlGroup->addButton(f1CheckBox, QSerialPort::NoFlowControl);
   flowCtlGroup->addButton(f2CheckBox, QSerialPort::HardwareControl);
   flowCtlGroup->addButton(f3CheckBox, QSerialPort::SoftwareControl);


#ifdef Q_OS_WIN32
   browseButton->setEnabled(false);
#else
   connect(browseButton, SIGNAL(clicked()), SLOT(browseButtonClicked()));
#endif


   connect(browse1PushButton, SIGNAL(clicked()), SLOT(browse1ButtonClicked()));
   connect(browse2PushButton, SIGNAL(clicked()), SLOT(browse2ButtonClicked()));
   //connect(browse3PushButton, SIGNAL(clicked()), SLOT(browse3ButtonClicked()));

   connect(saveButton, SIGNAL(clicked()), SLOT(saveButtonClicked()));
   connect(saveCloseButton, SIGNAL(clicked()), SLOT(saveCloseButtonClicked()));
   connect(deleteButton, SIGNAL(clicked()), SLOT(deleteButtonClicked()));
   connect(closeButton, SIGNAL(clicked()), SLOT(closeButtonClicked()));

   connect(autoSaveCheckBox, SIGNAL(stateChanged(int)), SLOT(autoSaveCheckBoxChanged(int)));
   connect(ext1ComboBox, SIGNAL(currentTextChanged(const QString)), SLOT(ext1BoxChanged(const QString)));
   connect(appendExtCheckBox, SIGNAL(stateChanged(int)), SLOT(appendExtCheckBoxChanged(int)));

   connect(flowCtlGroup, SIGNAL(buttonReleased(int)), SLOT(flowCtlGroupReleased()));

   loadSettings();
   flowCtlGroupReleased();

   connect(configNameBox, SIGNAL(currentIndexChanged(int)), SLOT(changeSettings()));
   connect(portNameComboBox, SIGNAL(currentIndexChanged(QString)), SLOT(portNameComboBoxIndexChanged(QString)));

   setResult(QDialog::Rejected);
}

//**************************************************************************************************
//
//**************************************************************************************************

SerialPortConfigDialog::~SerialPortConfigDialog()
{

}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::flowCtlGroupReleased()
{
   if(f2CheckBox->isChecked())
   {
      startDelaySpinBox->setEnabled(false);
      startDelaySpinBox->setValue(0);
   }
   else
   {
      startDelaySpinBox->setEnabled(true);
   };
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::browseButtonClicked()
{
   QString fileName = QFileDialog::getOpenFileName(
                         this,
                         tr("Select serial port device"),
                         portNameComboBox->currentText(),
                         tr("All files (*)"));

   QFileInfo file(fileName);

   if((file.exists()) && (file.isReadable()))
   {
      portNameComboBox->addItem(fileName);
      portNameComboBox->setCurrentIndex(portNameComboBox->count() - 1);
   };
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::saveButtonClicked()
{
    QStringList list;
    QString item, curItem;

    QSettings settings("EdytorNC", "EdytorNC");

    settings.beginGroup("SerialPortConfigs");

    curItem = configNameBox->currentText();

#ifndef Q_OS_WIN32
    list.clear();
    list.prepend(portNameComboBox->currentText());
    for(int i = 0; i <= portNameComboBox->count(); i++)
    {
       item = portNameComboBox->itemText(i);
       if(!item.isEmpty())
         if(!list.contains(item))
           list.prepend(item);
    };

    while(list.size() > 64)
    {
       list.removeLast();
    };
    settings.setValue("PortNameList", list);
#endif


    list.clear();
    list.prepend(configNameBox->currentText());
    for(int i = 0; i <= configNameBox->count(); i++)
    {
       item = configNameBox->itemText(i);
       if(!item.isEmpty())
         if(!list.contains(item))
           list.prepend(item);
    };

    while(list.size() > 64)
    {
       list.removeLast();
    };
    list.sort();
    settings.setValue("SettingsList", list);
    settings.setValue("CurrentSerialPortSettings", configNameBox->currentText());


    settings.beginGroup(configNameBox->currentText());

    settings.setValue("PortName", portNameComboBox->currentText());
    settings.setValue("BaudRate", baudGroup->checkedId());
    settings.setValue("DataBits", dataBitsGroup->checkedId());
    settings.setValue("StopBits", stopBitsGroup->checkedId());
    settings.setValue("Parity", parityGroup->checkedId());
    settings.setValue("FlowControl", flowCtlGroup->checkedId());
    settings.setValue("SendAtEnd", eotInput->text());
    settings.setValue("SendAtBegining", stInput->text());
    settings.setValue("LineDelay", delayDoubleSpinBox->value());
    settings.setValue("Xon", xonInput->text());
    settings.setValue("Xoff", xoffInput->text());
    settings.setValue("DeleteControlChars", deleteControlChars->isChecked());
    settings.setValue("RemoveEmptyLines", removeEmptyLines->isChecked());
    settings.setValue("RemoveBefore",removeBefore->isChecked());
    settings.setValue("SendingStartDelay", startDelaySpinBox->value());
    settings.setValue("AutoCloseTime", autoCloseSpinBox->value());
    settings.setValue("EndOfBlockLF", endOfBlockLF->isChecked());
    settings.setValue("RemoveSpaceEOB", removeSpaceEOB->isChecked());

    settings.setValue("AutoSave", autoSaveCheckBox->isChecked());

    settings.setValue("CreateLogFile", logFileCheckBox->isChecked());
    settings.setValue("CreateBackup", renameCheckBox->isChecked());
    settings.setValue("RemoveLetters", removeLettersCheckBox->isChecked());
    settings.setValue("DetectFormFileName", detectFormFileNameCheckBox->isChecked());
    settings.setValue("AppendExtension", appendExtCheckBox->isChecked());


    settings.setValue("SavePath", path1LineEdit->text());
    settings.setValue("SaveExt", ext1ComboBox->currentText().remove('*'));

    settings.endGroup();
    settings.endGroup();


    configNameBox->clear();
    configNameBox->addItems(list);
    int id = configNameBox->findText(curItem);
    if(id >= 0)
       configNameBox->setCurrentIndex(id);

}


//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::changeSettings()
{
    int id;
    QString item, port;

    QSettings settings("EdytorNC", "EdytorNC");

    QStringList extensions = settings.value("Extensions", (QStringList() << "*.nc" <<  "*.cnc")).toStringList();
    extensions.append("KEEP");
    extensions.removeDuplicates();
    extensions.replaceInStrings("*", "");
    ext1ComboBox->insertItems(0, extensions);
    ext2ComboBox->insertItems(0, extensions);
    //ext3ComboBox->insertItems(0, extensions);


    settings.beginGroup("SerialPortConfigs");
    settings.beginGroup(configNameBox->currentText());

#ifdef Q_OS_WIN32
    port = "COM1";
#else
    port = "/dev/ttyUSB0";
#endif

    item = settings.value("PortName", port).toString();
    id = portNameComboBox->findText(item);
    if(id == -1)
    {
        portNameComboBox->addItems(QStringList(item));
        id = portNameComboBox->findText(item);
    };
    portNameComboBox->setCurrentIndex(id);
    portNameComboBoxIndexChanged(item);

    id = settings.value("BaudRate", QSerialPort::Baud9600).toInt();
    switch(id)
    {
           case QSerialPort::Baud1200   : b3CheckBox->setChecked(true);
                break;
           case QSerialPort::Baud2400   : b4CheckBox->setChecked(true);
                break;
           case QSerialPort::Baud4800   : b5CheckBox->setChecked(true);
                break;
           case QSerialPort::Baud9600   : b6CheckBox->setChecked(true);
                break;
           case QSerialPort::Baud19200  : b7CheckBox->setChecked(true);
                break;
           case QSerialPort::Baud38400  : b8CheckBox->setChecked(true);
                break;
           case QSerialPort::Baud57600  : b9CheckBox->setChecked(true);
                break;
           case QSerialPort::Baud115200 : b11CheckBox->setChecked(true);
                break;
    };

    id = settings.value("DataBits", QSerialPort::Data8).toInt();
    switch(id)
    {
           case QSerialPort::Data5    : d1CheckBox->setChecked(true);
                break;
           case QSerialPort::Data6    : d2CheckBox->setChecked(true);
                break;
           case QSerialPort::Data7    : d3CheckBox->setChecked(true);
                break;
           case QSerialPort::Data8    : d4CheckBox->setChecked(true);
                break;
    };

    id = settings.value("StopBits", QSerialPort::TwoStop).toInt();
    switch(id)
    {
           case QSerialPort::OneStop    : s1CheckBox->setChecked(true);
                break;
           case QSerialPort::TwoStop    : s2CheckBox->setChecked(true);
                break;
    };

    id = settings.value("Parity", QSerialPort::NoParity).toInt();
    switch(id)
    {
           case QSerialPort::NoParity   : p1CheckBox->setChecked(true);
                break;
           case QSerialPort::OddParity  : p2CheckBox->setChecked(true);
                break;
           case QSerialPort::EvenParity : p3CheckBox->setChecked(true);
                break;
    };

    id = settings.value("FlowControl", QSerialPort::HardwareControl).toInt();
    switch(id)
    {
           case QSerialPort::NoFlowControl      : f1CheckBox->setChecked(true);
                break;
           case QSerialPort::HardwareControl    : f2CheckBox->setChecked(true);
                break;
           case QSerialPort::SoftwareControl    : f3CheckBox->setChecked(true);
                break;
    };

    eotInput->setText(settings.value("SendAtEnd", "").toString());
    stInput->setText(settings.value("SendAtBegining", "").toString());
    xonInput->setText(settings.value("Xon", "17").toString());
    xoffInput->setText(settings.value("Xoff", "19").toString());
    delayDoubleSpinBox->setValue(settings.value("LineDelay", 0).toDouble());
    deleteControlChars->setChecked(settings.value("DeleteControlChars", true).toBool());
    removeEmptyLines->setChecked(settings.value("RemoveEmptyLines", true).toBool());
    removeBefore->setChecked(settings.value("RemoveBefore", false).toBool());
    startDelaySpinBox->setValue(settings.value("SendingStartDelay", 0).toInt());
    autoCloseSpinBox->setValue(settings.value("AutoCloseTime", 15).toInt());
    endOfBlockLF->setChecked(settings.value("EndOfBlockLF", false).toBool());
    removeSpaceEOB->setChecked(settings.value("RemoveSpaceEOB", false).toBool());

    autoSaveCheckBox->setChecked(settings.value("AutoSave", false).toBool());
    logFileCheckBox->setChecked(settings.value("CreateLogFile", true).toBool());
    renameCheckBox->setChecked(settings.value("CreateBackup", true).toBool());
    removeLettersCheckBox->setChecked(settings.value("RemoveLetters", true).toBool());
    detectFormFileNameCheckBox->setChecked(settings.value("DetectFormFileName", true).toBool());
    appendExtCheckBox->setChecked(settings.value("AppendExtension", false).toBool());

    path1LineEdit->setText(settings.value("SavePath", "").toString());
    id = ext1ComboBox->findText(settings.value("SaveExt", ".nc").toString());
    if(id >= 0)
       ext1ComboBox->setCurrentIndex(id);


    settings.endGroup();
    settings.endGroup();

    autoSaveCheckBoxChanged((autoSaveCheckBox->isChecked() ? Qt::Checked : Qt::Unchecked));
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::loadSettings()
{
    int id;
    QStringList list;

    QSettings settings("EdytorNC", "EdytorNC");

    settings.beginGroup("SerialPortConfigs");

    foreach(const QSerialPortInfo &info, QSerialPortInfo::availablePorts())
    {
        list.append(info.portName());
    };

    list.removeDuplicates();
    list.sort();
    portNameComboBox->clear();
    portNameComboBox->addItems(list);


    configNameBox->clear();
    list = settings.value("SettingsList", tr("Default")).toStringList();
    list.sort();
    configNameBox->addItems(list);
    //item = settings.value("CurrentSerialPortSettings", tr("Default")).toString();
    id = configNameBox->findText(configName);
    configNameBox->setCurrentIndex(id);
    settings.endGroup();

    changeSettings();
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::portNameComboBoxIndexChanged(QString name)
{
    QString description;
    QString manufacturer;
    QString serialNumber;

    QSerialPortInfo *info = new QSerialPortInfo(name);

    description = info->description();
    manufacturer = info->manufacturer();
    serialNumber = info->serialNumber();

    portInfoListWidget->clear();
    //portInfoListWidget->addItem(tr("Port name:          %1").arg(info->portName()));
    portInfoListWidget->addItem(tr("Description       : %1").arg((!description.isEmpty() ? description : blankString)));
    portInfoListWidget->addItem(tr("Manufacturer      : %1").arg((!manufacturer.isEmpty() ? manufacturer : blankString)));
    portInfoListWidget->addItem(tr("SerialNumber      : %1").arg((!serialNumber.isEmpty() ? serialNumber : blankString)));
    portInfoListWidget->addItem(tr("System location   : %1").arg(info->systemLocation()));
    portInfoListWidget->addItem(tr("Vendor identifier : %1").arg((info->vendorIdentifier() ? QString::number(info->vendorIdentifier(), 16) : blankString)));
    portInfoListWidget->addItem(tr("Product identifier: %1").arg((info->productIdentifier() ? QString::number(info->productIdentifier(), 16) : blankString)));

}


//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::deleteButtonClicked()
{

    QSettings settings("EdytorNC", "EdytorNC");

    settings.beginGroup("SerialPortConfigs");
    settings.remove(configNameBox->currentText());
    settings.endGroup();

    int id = configNameBox->findText(configNameBox->currentText());
    configNameBox->removeItem(id);

}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::closeButtonClicked()
{
   QSettings settings("EdytorNC", "EdytorNC");
   settings.beginGroup("SerialPortConfigs");
   settings.setValue("CurrentSerialPortSettings", configNameBox->currentText());
   settings.endGroup();

   close();
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::saveCloseButtonClicked()
{
   saveButtonClicked();
   closeButtonClicked();
   accept();
}

//**************************************************************************************************
//
//**************************************************************************************************

QString SerialPortConfigDialog::browseForDir(QString dir, QString windowTitle)
{
    QDir directory(dir);

    if((!directory.exists()) || (!directory.isReadable()) || (dir.isEmpty()))
        directory.setPath(QDir::homePath());

    dir = QFileDialog::getExistingDirectory(
                this,
                windowTitle,
                directory.canonicalPath(),
                QFileDialog::ShowDirsOnly);

    if(!dir.isEmpty())
    {
        directory.setPath(dir);
    };

    return directory.canonicalPath();
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::browse1ButtonClicked()
{
   path1LineEdit->setText(browseForDir(path1LineEdit->text(), tr("Select save path")));
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::browse2ButtonClicked()
{
   path2LineEdit->setText(browseForDir(path2LineEdit->text(), tr("Select save path")));
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::browse3ButtonClicked()
{
   //path3LineEdit->setText(browseForDir(path3LineEdit->text(), tr("Select save path")));
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::autoSaveCheckBoxChanged(int state)
{
   path1LineEdit->setEnabled(state == Qt::Checked);
   ext1ComboBox->setEnabled(state == Qt::Checked);
   browse1PushButton->setEnabled(state == Qt::Checked);
   renameCheckBox->setEnabled(state == Qt::Checked);
   removeLettersCheckBox->setEnabled(state == Qt::Checked);
   detectFormFileNameCheckBox->setEnabled(state == Qt::Checked);
   appendExtCheckBox->setEnabled(state == Qt::Checked);
   //logFileCheckBox->setEnabled(state == Qt::Checked);

}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::ext1BoxChanged(const QString text)
{
    if(text == "KEEP")
        appendExtCheckBox->setChecked(false);
}

//**************************************************************************************************
//
//**************************************************************************************************

void SerialPortConfigDialog::appendExtCheckBoxChanged(int state)
{
    if(state == Qt::Checked)
        if(ext1ComboBox->currentText() == "KEEP")
            ext1ComboBox->setCurrentIndex(ext1ComboBox->currentIndex() - 1);
}




