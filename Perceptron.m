
%READS DATA FROM DATABASE
fullData = csvread('irisData.rtf');

fullDataSize = size(fullData);
fullDataSize = fullDataSize(1);


numberOfErrors = 0;

for i = 1 : 100
    
    % SUFFLE ELEMENTS OF DATA ARRAY
    fullData = fullData(randperm(fullDataSize),:);
    
    % SPLIT IT IN TWO DIFFERENT ARRAYS
    trainningData = fullData(1:100,:);
    testData = fullData(101:end,:);
    
    data = trainningData;
    
    %GETTING DATA WIDTH AND HEIGHT
    width = size(data);
    width = width(2);
    totalHeight = size(fullData);
    totalHeight = totalHeight(1);
    height = size(data);
    height = height(1);
    
    %SETTING BIAS AND EPOQUES
    bias = [-1 -1 -1];
    e = [0 0 0];
    w = zeros(3, 5);
    learning = 0.5;
    
    inputs = data(:, 1:width-3);
    correctOutputs = data(:, width-2:width);
    
    stopCriteria = 150;
    
    %==========================================
    % PASSO 2:
    % APLICAR OS PADR?ES COM SEUS VALORES DE ENTRADA (t) E VERIFICAR A SAIDA (s)
    
    numberOfEpoques = 0;
    allCorrect = 0;
    
    while allCorrect == 0
        
        for i = 1:height
            repMatriz =  repmat([inputs(i, :), bias(1)], 3, 1);
            inputsMatriz = [inputs(i, :), bias(1)];
            output = inputsMatriz * w.';
            signal = sinalDe(output);
            
            % PASSO 3:
            % CALCULAR O ERRO
            % e = u - y
            
            e = correctOutputs(i,:) - signal;
            
            % PASSO 4:
            % SE ERRO = 0, VOLTA PRA PASSO 2, CASO CONTR?RIO ATUALIZA OS PESOS
            
            
            
            if numberOfEpoques > stopCriteria
                allCorrect = 1;
                'Pesos Corretos';
                numberOfEpoques;
                w;
            end
            
            if (e(1) == 0 && e(2) == 0 && e(3) == 0)
                
                continue
            else
                
                % ATUALIZAR OS PESOS
                % Wnovo = Wanterior + taxa de aprendizado (pelo programador) * E * xi
                
                deltaW = (learning * e.' * inputsMatriz)
                w = w + deltaW ;
                
                
                numberOfEpoques = numberOfEpoques + 1;
                
                break
                
            end
            
            
        end
        
    end
    
    
    % %==========================================
    % %             ZONA DE TESTE
    % %==========================================
    %
    % % SPLIT INTO A TEST ARRAY WITH THE VALUES AND ASWERS ARRAY WITH CORRECT
    % % ANSWERS
    
    testArray = testData(:,1:width-3);
    biasArray = repmat(-1, 50, 1);
    testArray = [testArray, biasArray];
    
    correctAnswers = testData(:, width-2:width);
    %
    % % MULTIPLY TEST ARRAY WITH WEIGHTS ARRAY TO CLASSIFY DATA
    answers = testArray * w.' ;
    
    finalAnswers = [];
    correctCount = 0;
    
    %     for i = 1:totalHeight-height
    %         signal = sinalDe(answers(i,:));
    %
    %         if signal - correctAnswers(i,:) == [0 0 0]
    %             correctCount = correctCount + 1;
    %         end
    %         finalAnswers = [finalAnswers; signal - correctAnswers(i,:)];
    %     end
    %
    %     finalAnswers
    %
    % % GET THE SIGNAL VALUE OF THE ANSWERS
    for i = 1 : totalHeight - height
        answers(i,:) = sinalDe(answers(i,:));
    end
    %
    % % VERIFY IF THERE IS ANY ERROR
    evaluation = answers - correctAnswers;
    %
    %containsNot0 = any(evaluation(:, :) ~= 0);
    %
    % containsNot0 = nnz(evaluation~=0);
    containsNot0 = sum(evaluation(:,:) ~= 0)
    %
        numberOfErrors = numberOfErrors + max(containsNot0);
    %
    
    
end

numberOfErrors

function y = sinalDe(x)

width = size(x);


for n = 1:width(2)
    
    if x(n) > 0
        y(n) = 1;
    else
        y(n) = 0;
    end
    
end


end




