%Script Alloy Converter
%Input and Postprocessing Script for AlloyConverter Function

%% Test a.% -> wt.%
% 1.4418 a.% -> wt.%
% elements =      {'CR'  'NI'  'MN'  'MO'  'SI'  'C'  'N'  'P'  'S' };                        %Elements
% percentages =   [15.9444 5.4611 0.8652 0.5934 0.7675 0.1380 0.1460 0.0446 0.0138];          %Percentages
% balanced_element = 'Fe';                                                                    %Balanced Element
% mode = 2;                                                                                   %Mode [1: weight to molar, 2: molar to weight]

%% Test wt.% -> a.%
%1.4418 detailed a.% -> wt.%
elements =       {'CR'  'NI'  'MN'  'MO' 'SI' 'C' 'N' 'P' 'S' 'Cu' 'Nb' 'Ti' 'Co' 'Al' 'V'};                 %Elements
percentages =   [15.0 5.8 0.86 1.03 0.39 0.03 0.037 0.025 0.008 0.32 0.006 0.007 0.11 0.005 0.045];          %Percentages
balanced_element = 'Fe';                                                                                     %Balanced Element
mode = 1;                                                                                                    %Mode [1: weight to molar, 2: molar to weight]
%Run AlloyConverter
converted_data = AlloyConverter(elements,percentages,balanced_element,mode);

%Output
clear elements percentages balanced_element mode
disp(converted_data);