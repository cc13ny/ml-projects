 HISTORY = { 'LVFAILURE', {
  'TRUE', 0.9, 0.1;
  'FALSE', 0.01, 0.99;
}};
 CVP = { 'LVEDVOLUME', {
  'LOW', 0.95, 0.04, 0.01;
  'NORMAL', 0.04, 0.95, 0.01;
  'HIGH', 0.01, 0.29, 0.7;
}};
 PCWP = { 'LVEDVOLUME', {
  'LOW', 0.95, 0.04, 0.01;
  'NORMAL', 0.04, 0.95, 0.01;
  'HIGH', 0.01, 0.04, 0.95;
}};
 HYPOVOLEMIA = {
   [0.2, 0.8];
   };

 LVEDVOLUME = { 'HYPOVOLEMIA', 'LVFAILURE', {
  'TRUE', 'TRUE', 0.95, 0.04, 0.01;
  'FALSE', 'TRUE', 0.98, 0.01, 0.01;
  'TRUE', 'FALSE', 0.01, 0.09, 0.9;
  'FALSE', 'FALSE', 0.05, 0.9, 0.05;
}};
 LVFAILURE = {
   [0.05, 0.95];
};
 STROKEVOLUME = { 'HYPOVOLEMIA', 'LVFAILURE', {
  'TRUE', 'TRUE', 0.98, 0.01, 0.01;
  'FALSE', 'TRUE', 0.95, 0.04, 0.01;
  'TRUE', 'FALSE', 0.5, 0.49, 0.01;
  'FALSE', 'FALSE', 0.05, 0.9, 0.05;
}};
 ERRLOWOUTPUT = {
   [0.05, 0.95];
};
 HRBP = { 'ERRLOWOUTPUT', 'HR', {
  'TRUE', 'LOW', 0.98, 0.01, 0.01;
  'FALSE', 'LOW', 0.4, 0.59, 0.01;
  'TRUE', 'NORMAL', 0.3, 0.4, 0.3;
  'FALSE', 'NORMAL', 0.98, 0.01, 0.01;
  'TRUE', 'HIGH', 0.01, 0.98, 0.01;
  'FALSE', 'HIGH', 0.01, 0.01, 0.98;
}};
 HREKG = { 'ERRCAUTER', 'HR', {
  'TRUE', 'LOW', 0.33333334, 0.33333334, 0.33333334;
  'FALSE', 'LOW', 0.33333334, 0.33333334, 0.33333334;
  'TRUE', 'NORMAL', 0.33333334, 0.33333334, 0.33333334;
  'FALSE', 'NORMAL', 0.98, 0.01, 0.01;
  'TRUE', 'HIGH', 0.01, 0.98, 0.01;
  'FALSE', 'HIGH', 0.01, 0.01, 0.98;
}};
  ERRCAUTER = {
   [0.1, 0.9];
};
 HRSAT = { 'ERRCAUTER', 'HR', {
  'TRUE', 'LOW', 0.33333334, 0.33333334, 0.33333334;
  'FALSE', 'LOW', 0.33333334, 0.33333334, 0.33333334;
  'TRUE', 'NORMAL', 0.33333334, 0.33333334, 0.33333334;
  'FALSE', 'NORMAL', 0.98, 0.01, 0.01;
  'TRUE', 'HIGH', 0.01, 0.98, 0.01;
  'FALSE', 'HIGH', 0.01, 0.01, 0.98;
}};
 INSUFFANESTH = {
  [0.1, 0.9];
};
 ANAPHYLAXIS = {
   [0.01, 0.99];
};
 TPR = { 'ANAPHYLAXIS', {
  'TRUE', 0.98, 0.01, 0.01;
  'FALSE', 0.3, 0.4, 0.3;
}};
 EXPCO2 = { 'ARTCO2', 'VENTLUNG', {
  'LOW', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'ZERO', 0.01, 0.97, 0.01, 0.01;
  'HIGH', 'ZERO', 0.01, 0.97, 0.01, 0.01;
  'LOW', 'LOW', 0.01, 0.97, 0.01, 0.01;
  'NORMAL', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'HIGH', 'LOW', 0.01, 0.01, 0.97, 0.01;
  'LOW', 'NORMAL', 0.01, 0.01, 0.97, 0.01;
  'NORMAL', 'NORMAL', 0.01, 0.01, 0.97, 0.01;
  'HIGH', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'LOW', 'HIGH', 0.01, 0.01, 0.01, 0.97;
  'NORMAL', 'HIGH', 0.01, 0.01, 0.01, 0.97;
  'HIGH', 'HIGH', 0.01, 0.01, 0.01, 0.97;
}};
 KINKEDTUBE = {
   [0.04, 0.96];
};
 MINVOL = { 'INTUBATION', 'VENTLUNG', {
  'NORMAL', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'ZERO', 0.01, 0.97, 0.01, 0.01;
  'ONESIDED', 'ZERO', 0.01, 0.01, 0.97, 0.01;
  'NORMAL', 'LOW', 0.01, 0.01, 0.01, 0.97;
  'ESOPHAGEAL', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'LOW', 0.6, 0.38, 0.01, 0.01;
  'NORMAL', 'NORMAL', 0.5, 0.48, 0.01, 0.01;
  'ESOPHAGEAL', 'NORMAL', 0.5, 0.48, 0.01, 0.01;
  'ONESIDED', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'HIGH', 0.01, 0.97, 0.01, 0.01;
  'ESOPHAGEAL', 'HIGH', 0.01, 0.01, 0.97, 0.01;
  'ONESIDED', 'HIGH', 0.01, 0.01, 0.01, 0.97;
}};
 FIO2 = {
   [0.05, 0.95];
};
 PVSAT = { 'FIO2', 'VENTALV', {
  'LOW', 'ZERO', 1.0, 0.0, 0.0;
  'NORMAL', 'ZERO', 0.99, 0.01, 0.0;
  'LOW', 'LOW', 0.95, 0.04, 0.01;
  'NORMAL', 'LOW', 0.95, 0.04, 0.01;
  'LOW', 'NORMAL', 1.0, 0.0, 0.0;
  'NORMAL', 'NORMAL', 0.95, 0.04, 0.01;
  'LOW', 'HIGH', 0.01, 0.95, 0.04;
  'NORMAL', 'HIGH', 0.01, 0.01, 0.98;
}};
 SAO2 = { 'PVSAT', 'SHUNT', {
  'LOW', 'NORMAL', 0.98, 0.01, 0.01;
  'NORMAL', 'NORMAL', 0.01, 0.98, 0.01;
  'HIGH', 'NORMAL', 0.01, 0.01, 0.98;
  'LOW', 'HIGH', 0.98, 0.01, 0.01;
  'NORMAL', 'HIGH', 0.98, 0.01, 0.01;
  'HIGH', 'HIGH', 0.69, 0.3, 0.01;
}};
 PAP = { 'PULMEMBOLUS', {
  'TRUE', 0.01, 0.19, 0.8;
  'FALSE', 0.05, 0.9, 0.05;
}};
 PULMEMBOLUS = {
   [0.01, 0.99];
};
 SHUNT = { 'INTUBATION', 'PULMEMBOLUS', {
  'NORMAL', 'TRUE', 0.1, 0.9;
  'ESOPHAGEAL', 'TRUE', 0.1, 0.9;
  'ONESIDED', 'TRUE', 0.01, 0.99;
  'NORMAL', 'FALSE', 0.95, 0.05;
  'ESOPHAGEAL', 'FALSE', 0.95, 0.05;
  'ONESIDED', 'FALSE', 0.05, 0.95;
}};
 INTUBATION = {
   [0.92, 0.03, 0.05];
};
 PRESS = { 'INTUBATION', 'KINKEDTUBE', 'VENTTUBE', {
  'NORMAL', 'TRUE', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'TRUE', 'ZERO', 0.01, 0.3, 0.49, 0.2;
  'ONESIDED', 'TRUE', 'ZERO', 0.01, 0.01, 0.08, 0.9;
  'NORMAL', 'FALSE', 'ZERO', 0.01, 0.01, 0.01, 0.97;
  'ESOPHAGEAL', 'FALSE', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'FALSE', 'ZERO', 0.1, 0.84, 0.05, 0.01;
  'NORMAL', 'TRUE', 'LOW', 0.05, 0.25, 0.25, 0.45;
  'ESOPHAGEAL', 'TRUE', 'LOW', 0.01, 0.15, 0.25, 0.59;
  'ONESIDED', 'TRUE', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'FALSE', 'LOW', 0.01, 0.29, 0.3, 0.4;
  'ESOPHAGEAL', 'FALSE', 'LOW', 0.01, 0.01, 0.08, 0.9;
  'ONESIDED', 'FALSE', 'LOW', 0.01, 0.01, 0.01, 0.97;
  'NORMAL', 'TRUE', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'TRUE', 'NORMAL', 0.01, 0.97, 0.01, 0.01;
  'ONESIDED', 'TRUE', 'NORMAL', 0.01, 0.01, 0.97, 0.01;
  'NORMAL', 'FALSE', 'NORMAL', 0.01, 0.01, 0.01, 0.97;
  'ESOPHAGEAL', 'FALSE', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'FALSE', 'NORMAL', 0.4, 0.58, 0.01, 0.01;
  'NORMAL', 'TRUE', 'HIGH', 0.2, 0.75, 0.04, 0.01;
  'ESOPHAGEAL', 'TRUE', 'HIGH', 0.2, 0.7, 0.09, 0.01;
  'ONESIDED', 'TRUE', 'HIGH', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'FALSE', 'HIGH', 0.010000001, 0.90000004, 0.080000006, 0.010000001;
  'ESOPHAGEAL', 'FALSE', 'HIGH', 0.01, 0.01, 0.38, 0.6;
  'ONESIDED', 'FALSE', 'HIGH', 0.01, 0.01, 0.01, 0.97;
}};
 DISCONNECT = {
   [0.1, 0.9];
};
 MINVOLSET = {
   [0.05, 0.9, 0.05];
};
 VENTMACH = { 'MINVOLSET', {
  'LOW', 0.05, 0.93, 0.01, 0.01;
  'NORMAL', 0.05, 0.01, 0.93, 0.01;
  'HIGH', 0.05, 0.01, 0.01, 0.93;
}};
 VENTTUBE = { 'DISCONNECT', 'VENTMACH', {
  'TRUE', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'FALSE', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'TRUE', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'FALSE', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'TRUE', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'FALSE', 'NORMAL', 0.01, 0.97, 0.01, 0.01;
  'TRUE', 'HIGH', 0.01, 0.01, 0.97, 0.01;
  'FALSE', 'HIGH', 0.01, 0.01, 0.01, 0.97;
}};
 VENTLUNG = { 'INTUBATION', 'KINKEDTUBE', 'VENTTUBE', {
  'NORMAL', 'TRUE', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'TRUE', 'ZERO', 0.95000005, 0.030000001, 0.010000001, 0.010000001;
  'ONESIDED', 'TRUE', 'ZERO', 0.4, 0.58, 0.01, 0.01;
  'NORMAL', 'FALSE', 'ZERO', 0.3, 0.68, 0.01, 0.01;
  'ESOPHAGEAL', 'FALSE', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'FALSE', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'TRUE', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'TRUE', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'TRUE', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'FALSE', 'LOW', 0.95000005, 0.030000001, 0.010000001, 0.010000001;
  'ESOPHAGEAL', 'FALSE', 'LOW', 0.5, 0.48, 0.01, 0.01;
  'ONESIDED', 'FALSE', 'LOW', 0.3, 0.68, 0.01, 0.01;
  'NORMAL', 'TRUE', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'TRUE', 'NORMAL', 0.01, 0.97, 0.01, 0.01;
  'ONESIDED', 'TRUE', 'NORMAL', 0.01, 0.01, 0.97, 0.01;
  'NORMAL', 'FALSE', 'NORMAL', 0.01, 0.01, 0.01, 0.97;
  'ESOPHAGEAL', 'FALSE', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'FALSE', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'TRUE', 'HIGH', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'TRUE', 'HIGH', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'TRUE', 'HIGH', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'FALSE', 'HIGH', 0.01, 0.97, 0.01, 0.01;
  'ESOPHAGEAL', 'FALSE', 'HIGH', 0.01, 0.01, 0.97, 0.01;
  'ONESIDED', 'FALSE', 'HIGH', 0.01, 0.01, 0.01, 0.97;
}};
 VENTALV = { 'INTUBATION', 'VENTLUNG', {
  'NORMAL', 'ZERO', 0.97, 0.01, 0.01, 0.01;
  'ESOPHAGEAL', 'ZERO', 0.01, 0.97, 0.01, 0.01;
  'ONESIDED', 'ZERO', 0.01, 0.01, 0.97, 0.01;
  'NORMAL', 'LOW', 0.01, 0.01, 0.01, 0.97;
  'ESOPHAGEAL', 'LOW', 0.97, 0.01, 0.01, 0.01;
  'ONESIDED', 'LOW', 0.01, 0.97, 0.01, 0.01;
  'NORMAL', 'NORMAL', 0.01, 0.01, 0.97, 0.01;
  'ESOPHAGEAL', 'NORMAL', 0.01, 0.01, 0.01, 0.97;
  'ONESIDED', 'NORMAL', 0.97, 0.01, 0.01, 0.01;
  'NORMAL', 'HIGH', 0.030000001, 0.95000005, 0.010000001, 0.010000001;
  'ESOPHAGEAL', 'HIGH', 0.01, 0.94, 0.04, 0.01;
  'ONESIDED', 'HIGH', 0.01, 0.88, 0.1, 0.01;
}};
 ARTCO2 = { 'VENTALV', {
  'ZERO', 0.01, 0.01, 0.98;
  'LOW', 0.01, 0.01, 0.98;
  'NORMAL', 0.04, 0.92, 0.04;
  'HIGH', 0.9, 0.09, 0.01;
}};
 CATECHOL = { 'ARTCO2', 'INSUFFANESTH', 'SAO2', 'TPR', {
  'LOW', 'TRUE', 'LOW', 'LOW', 0.01, 0.99;
  'NORMAL', 'TRUE', 'LOW', 'LOW', 0.01, 0.99;
  'HIGH', 'TRUE', 'LOW', 'LOW', 0.01, 0.99;
  'LOW', 'FALSE', 'LOW', 'LOW', 0.01, 0.99;
  'NORMAL', 'FALSE', 'LOW', 'LOW', 0.01, 0.99;
  'HIGH', 'FALSE', 'LOW', 'LOW', 0.01, 0.99;
  'LOW', 'TRUE', 'NORMAL', 'LOW', 0.01, 0.99;
  'NORMAL', 'TRUE', 'NORMAL', 'LOW', 0.01, 0.99;
  'HIGH', 'TRUE', 'NORMAL', 'LOW', 0.01, 0.99;
  'LOW', 'FALSE', 'NORMAL', 'LOW', 0.01, 0.99;
  'NORMAL', 'FALSE', 'NORMAL', 'LOW', 0.01, 0.99;
  'HIGH', 'FALSE', 'NORMAL', 'LOW', 0.01, 0.99;
  'LOW', 'TRUE', 'HIGH', 'LOW', 0.01, 0.99;
  'NORMAL', 'TRUE', 'HIGH', 'LOW', 0.01, 0.99;
  'HIGH', 'TRUE', 'HIGH', 'LOW', 0.01, 0.99;
  'LOW', 'FALSE', 'HIGH', 'LOW', 0.05, 0.95;
  'NORMAL', 'FALSE', 'HIGH', 'LOW', 0.05, 0.95;
  'HIGH', 'FALSE', 'HIGH', 'LOW', 0.01, 0.99;
  'LOW', 'TRUE', 'LOW', 'NORMAL', 0.01, 0.99;
  'NORMAL', 'TRUE', 'LOW', 'NORMAL', 0.01, 0.99;
  'HIGH', 'TRUE', 'LOW', 'NORMAL', 0.01, 0.99;
  'LOW', 'FALSE', 'LOW', 'NORMAL', 0.05, 0.95;
  'NORMAL', 'FALSE', 'LOW', 'NORMAL', 0.05, 0.95;
  'HIGH', 'FALSE', 'LOW', 'NORMAL', 0.01, 0.99;
  'LOW', 'TRUE', 'NORMAL', 'NORMAL', 0.05, 0.95;
  'NORMAL', 'TRUE', 'NORMAL', 'NORMAL', 0.05, 0.95;
  'HIGH', 'TRUE', 'NORMAL', 'NORMAL', 0.01, 0.99;
  'LOW', 'FALSE', 'NORMAL', 'NORMAL', 0.05, 0.95;
  'NORMAL', 'FALSE', 'NORMAL', 'NORMAL', 0.05, 0.95;
  'HIGH', 'FALSE', 'NORMAL', 'NORMAL', 0.01, 0.99;
  'LOW', 'TRUE', 'HIGH', 'NORMAL', 0.05, 0.95;
  'NORMAL', 'TRUE', 'HIGH', 'NORMAL', 0.05, 0.95;
  'HIGH', 'TRUE', 'HIGH', 'NORMAL', 0.01, 0.99;
  'LOW', 'FALSE', 'HIGH', 'NORMAL', 0.05, 0.95;
  'NORMAL', 'FALSE', 'HIGH', 'NORMAL', 0.05, 0.95;
  'HIGH', 'FALSE', 'HIGH', 'NORMAL', 0.01, 0.99;
  'LOW', 'TRUE', 'LOW', 'HIGH', 0.7, 0.3;
  'NORMAL', 'TRUE', 'LOW', 'HIGH', 0.7, 0.3;
  'HIGH', 'TRUE', 'LOW', 'HIGH', 0.1, 0.9;
  'LOW', 'FALSE', 'LOW', 'HIGH', 0.7, 0.3;
  'NORMAL', 'FALSE', 'LOW', 'HIGH', 0.7, 0.3;
  'HIGH', 'FALSE', 'LOW', 'HIGH', 0.1, 0.9;
  'LOW', 'TRUE', 'NORMAL', 'HIGH', 0.7, 0.3;
  'NORMAL', 'TRUE', 'NORMAL', 'HIGH', 0.7, 0.3;
  'HIGH', 'TRUE', 'NORMAL', 'HIGH', 0.1, 0.9;
  'LOW', 'FALSE', 'NORMAL', 'HIGH', 0.95, 0.05;
  'NORMAL', 'FALSE', 'NORMAL', 'HIGH', 0.99, 0.01;
  'HIGH', 'FALSE', 'NORMAL', 'HIGH', 0.3, 0.7;
  'LOW', 'TRUE', 'HIGH', 'HIGH', 0.95, 0.05;
  'NORMAL', 'TRUE', 'HIGH', 'HIGH', 0.99, 0.01;
  'HIGH', 'TRUE', 'HIGH', 'HIGH', 0.3, 0.7;
  'LOW', 'FALSE', 'HIGH', 'HIGH', 0.95, 0.05;
  'NORMAL', 'FALSE', 'HIGH', 'HIGH', 0.99, 0.01;
  'HIGH', 'FALSE', 'HIGH', 'HIGH', 0.3, 0.7;
}};
 HR = { 'CATECHOL', {
  'NORMAL', 0.05, 0.9, 0.05;
  'HIGH', 0.01, 0.09, 0.9;
}};
 CO = { 'HR', 'STROKEVOLUME', {
  'LOW', 'LOW', 0.98, 0.01, 0.01;
  'NORMAL', 'LOW', 0.95, 0.04, 0.01;
  'HIGH', 'LOW', 0.8, 0.19, 0.01;
  'LOW', 'NORMAL', 0.95, 0.04, 0.01;
  'NORMAL', 'NORMAL', 0.04, 0.95, 0.01;
  'HIGH', 'NORMAL', 0.01, 0.04, 0.95;
  'LOW', 'HIGH', 0.3, 0.69, 0.01;
  'NORMAL', 'HIGH', 0.01, 0.3, 0.69;
  'HIGH', 'HIGH', 0.01, 0.01, 0.98;
}};
 BP = { 'CO', 'TPR', {
  'LOW', 'LOW', 0.98, 0.01, 0.01;
  'NORMAL', 'LOW', 0.98, 0.01, 0.01;
  'HIGH', 'LOW', 0.9, 0.09, 0.01;
  'LOW', 'NORMAL', 0.98, 0.01, 0.01;
  'NORMAL', 'NORMAL', 0.1, 0.85, 0.05;
  'HIGH', 'NORMAL', 0.05, 0.2, 0.75;
  'LOW', 'HIGH', 0.3, 0.6, 0.1;
  'NORMAL', 'HIGH', 0.05, 0.4, 0.55;
  'HIGH', 'HIGH', 0.01, 0.09, 0.9;
}};
