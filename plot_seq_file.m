% !! make this files folder your current folder !!
if strcmp(mfilename, 'LiveEditorEvaluationHelperESectionEval')
    cd(fileparts(matlab.desktop.editor.getActiveFilename));
else
    cd(fileparts(which(mfilename)));
end

addpath(genpath(pwd));

seq = mr.Sequence();

seq.read(uigetfile({'*.seq','All .seq Files'},'mytitle','cest-seq-library'));

%% plot only from first to second ADC,
% with time unit ms and RF unit �T
t=0; tADC=[];
for iB=1:length(seq.blockEvents)
    block = seq.getBlock(iB);
    t=t+mr.calcDuration(block);
    if ~isempty(block.adc)
        tADC(end+1)=t; % save time of ADC events here
    end
end

seq.plot('TimeRange',[tADC(1)-0.02 tADC(2)],'timeDisp','ms','rfDisp','uT','gammaHz',42.5764)

%% plot from start to second ADC to see M0 recovery delays
seq.plot('TimeRange',[0 tADC(2)],'timeDisp','ms','rfDisp','uT','gammaHz',42.5764);

%% plot full sequence
% with time unit s and RF unit Hz
seq.plot();
