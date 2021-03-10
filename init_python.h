#ifndef INIT_PYTHON_H
#define INIT_PYTHON_H

#include <Python.h>
#include <QString>
#include <map>
#include <QDebug>

class Python {
public:
    Python(QString python_path = "") {}
    ~Python() {}

    void importFunc(const char *module_name, const char * func) {
        auto module_iter = module_map.find(module_name);
        if (module_iter == module_map.end()) {
            qDebug() << module_name << " not found." << endl;
            return;
        }
        PyObject *module = module_iter->second;
        if (module == nullptr) {
            return;
        }
        PyObject *py_func = PyObject_GetAttrString(module, func);
        if (py_func == nullptr) {
            qDebug() << func << " import fail." <<endl;
            return;
        }
        func_map[std::string(module_name) + "." + std::string(func)] =  py_func;
    }
    void importModule(const char* module) {
        PyObject *py_module = PyImport_ImportModule(module);
        if (py_module == nullptr) {
            qDebug() << module << " import fail." << endl;
            return;
        }
        module_map[std::string(module)] = py_module;
    }

    PyObject* getModule(const char *module) {
        auto py_module = module_map.find(module);
        if (py_module == module_map.end()) {
            return nullptr;
        }
        return py_module->second;
    }

    PyObject* getFunc(const char *module_name, const char *func_name) {
        std::string key = std::string(module_name) + "." + std::string(func_name);
        auto py_func = func_map.find(key);
        if (py_func == func_map.end()) {
            return nullptr;
        }
        return py_func->second;
    }
private:
    std::map<std::string, PyObject*> module_map;
    std::map<std::string, PyObject*> func_map;
};


extern Python python;

#endif // INIT_PYTHON_H
