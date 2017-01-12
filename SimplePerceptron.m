%==========================================
% PASSO 1:
% INICIAR OS PESOS W COM VALORES 0
%==========================================
% OR
%data = [0 0 0; 0 1 1; 1 0 1; 1 1 1];
%data = [1 0 0 0; 1 0 1 1; 1 1 0 1; 1 1 1 1];
% AND
%data = [0 0 0; 0 1 0; 1 0 0; 1 1 1];
data = [1 0 0 0; 1 0 1 0; 1 1 0 0; 1 1 1 1];
%data = [0 0 0 0; 0 0 1 0; 0 1 0 0; 1 1 1 1];

% NOT
%data = [1 0 1; 1 1 0 ];

width = size(data)
width = width(2)
height = size(data)
height = height(1)


bias = 0;
epoques = 0;
e = 0;
w = zeros(width-1, 1);
learning = 0.5;

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

    % valor de u (Regra de Propaga??o)
    % somat?rio de peso * valor de entrada

% y = 1 se u > 0, y = -1 se u <= 0
%==========================================






%==========================================

%==========================================


%==========================================
% PASSO 5:

%==========================================
function y = sinalDe(x)
    if x > 0 
        y = 1;
    else 
        y = 0;
    end
end
