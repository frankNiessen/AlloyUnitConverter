%AlloyConverter
%function[ConvertedData] = AlloyConverter(Elements,Percentages,BalancedElement,Mode)
%Conversion of atomic to weight fraction and vice versa
%Copyright Frank Niessen, DTU Denmark 2015/11 - No Accuracy promised or warrantee taken by the author
%
%Elements:          Structure Array with short Symbols of Alloying Elements
%Percentages:       Array of percentages of Alloying Elements (weight or atomic)
%BalancedElement:   String of Balanced Element short Symbol
%Mode:              Integer [1]: Weight Percent to Atomic Percent
                          % [2]: Atomic Percent to Weight Percent

function[ConvertedData] = AlloyConverter(Elements,Percentages,BalancedElement,Mode)
%% Initialisation
Proc.Elements = Elements;
Proc.Percentages = Percentages;
clear elements percentages
%Read Structural Data
Temp = open('Data.mat');
Data = Temp.Data;
clear Temp

%% Pre-Processing
%Adding balanced element to alloying elements
NrAlloyingElements = length(Proc.Elements);
NrElements = NrAlloyingElements + 1;
Proc.ElementNrs = NaN(NrElements,1);
Proc.Elements{NrElements} = BalancedElement;
Proc.Percentages(NrElements) = 100 - sum(Proc.Percentages);

%Converting element names to Upper case
Proc.Elements = upper(Proc.Elements);

%Read element Nrs
for i = 1:NrElements
   Proc.ElementNrs(i) = find(strcmpi(Data.Element,Proc.Elements{i}));
end
Proc.AtomicMasses = Data.AtomicMass(Proc.ElementNrs);

%% Conversion
if Mode == 1 %Weight Percent to Atomic Percent    
    Proc.ElementNrAtoms = Proc.Percentages./Proc.AtomicMasses';
    Proc.NrAtoms = sum(Proc.ElementNrAtoms);
    Proc.AtomicPercent = Proc.ElementNrAtoms/Proc.NrAtoms*100;
    
    %Preparing Output Variable
    ConvertedData.Percentages =  Proc.AtomicPercent;
    ConvertedData.Elements = Proc.Elements;
    ConvertedData.Units = 'a.%';
    
elseif Mode == 2 %Atomic Percent to Mass Percent
    Proc.P = Proc.Percentages .* Proc.AtomicMasses';
    Proc.PTot = sum(Proc.P);
    Proc.WeightPercent = Proc.P / Proc.PTot*100;
    
    %Preparing Output Variable
    ConvertedData.Percentages =  Proc.WeightPercent;
    ConvertedData.Elements = Proc.Elements;
    ConvertedData.Units = 'wt.%';
end