
%READS DATA FROM DATABASE
fullData = csvread('irisData.dat')

fullDataSize = size(fullData)
fullDataSize = fullDataSize(1)


numberOfErrors = 0

for i = 1 : 100

% SUFFLE ELEMENTS OF DATA ARRAY
fullData = fullData(randperm(fullDataSize),:);

% SPLIT IT IN TWO DIFFERENT ARRAYS
trainningData = fullData(1:60,:)
testData = fullData(61:end,:)

data = trainningData

%GETTING DATA WIDTH AND HEIGHT 
width = size(data);
width = width(2);
totalHeight = size(fullData);
totalHeight = totalHeight(1);
height = size(data);
height = height(1);

%SETTING BIAS AND EPOQUES
bias = -1;
e = 0;
w = zeros(width-1, 1);
learning = 1;

inputs = data(:, 1:width-1);
correctOutputs = data(:, width);



%==========================================
% PASSO 2:
% APLICAR OS PADR?ES COM SEUS VALORES DE ENTRADA (t) E VERIFICAR A SAIDA (s)

numberOfEpoques = 0;
allCorrect = 0;

while allCorrect == 0

    for i = 1:height 
        output = inputs(i, :)*w;
        signal = sinalDe(output);

        % PASSO 3:
        % CALCULAR O ERRO
        % e = u - y
            
        e = correctOutputs(i) - signal;

        % PASSO 4:
        % SE ERRO = 0, VOLTA PRA PASSO 2, CASO CONTR?RIO ATUALIZA OS PESOS
        if e == 0 && i == height
            allCorrect = 1; 
            'Pesos Corretos';
        end
        
        if e == 0
            continue
        else   
            
        % ATUALIZAR OS PESOS
        % Wnovo = Wanterior + taxa de aprendizado (pelo programador) * E * xi
            for j = 1:width-1
                w(j) = w(j) + learning * e * inputs(i, j);
            end
            
            numberOfEpoques = numberOfEpoques + 1;
            
            break
            
        end
        
        
    end

end


%==========================================
%             ZONA DE TESTE
%==========================================

% SPLIT INTO A TEST ARRAY WITH THE VALUES AND ASWERS ARRAY WITH CORRECT
% ANSWERS
testArray = testData(:,1:width-1);
correctAnswers = testData(:, width)';

% MULTIPLY TEST ARRAY WITH WEIGHTS ARRAY TO CLASSIFY DATA
answers = w'*testArray';

% GET THE SIGNAL VALUE OF THE ANSWERS
for i = 1 : totalHeight - height
    answers(i) = sinalDe(answers(i));
end

% VERIFY IF THERE IS ANY ERROR
evaluation = answers - correctAnswers;

%containsNot0 = any(evaluation(:, :) ~= 0);

% containsNot0 = nnz(evaluation~=0);
containsNot0 = sum(evaluation(:,:) ~= 0)

    if containsNot0 == 1
        numberOfErrors = numberOfErrors + containsNot0;
    end



end


function y = sinalDe(x)
    if x > 0 
        y = 1;
    else 
        y = 0;
    end
end
