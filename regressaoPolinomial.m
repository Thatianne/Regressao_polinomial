function regressaoPolinomial(x, y, m)

    [j, i] = size(x);    
    novoY = [y, (sum(y)/i)];
    somatoriosX = zeros( m+2, 1);
    somatoriosX(1, 1) = sum(x);
    somatoriosXY = zeros(m+1, 1);
    somatoriosXY(1, 1) = sum(y);
    xExp = zeros(i, m + 1);
    xyExp = zeros(i, m);
    cc = zeros(i, 1);
    
    for a=1:m+1
        for b=1:i
            xExp(b, a) = x(1, b)^(a+1);
            
            if a <= m
                xyExp(b, a) = (x(1, b)^a) * y(1, b);
            end
           
            if a < 2
                cc(b, 1) = (y(1, b) - novoY(1, i+1))^2;
            end
        end
        
        somatoriosX(a+1, 1) = sum(xExp(1:b, a:a));        
        
        if a <= m
            somatoriosXY( a+1, 1) = sum(xyExp(1:b, a:a));            
        end
    end
    
    sistema = ones(m+1, m+1);
    igualdade = somatoriosXY;
    
    cont = 0;
    for a=1:m+1        
        for b=1:m+1
            if a == 1 && b == 1
                sistema(a, b) = i;
            else
                sistema(a, b) = somatoriosX(b+cont-1, 1);    
            end            
        end
        cont = cont + 1;
    end
    
    coeficientes = sistema \ igualdade;        
    
    %Desvio padr�o (Sy)
    st = sum(cc);   
    sy = sqrt(st/(i-1));
    
    %Erro padr�o Sy/x
    resultados = ones(1, i);
    for a=1:i
        valor = 0;
        for b=1:m + 1            
            if b==1
                valor = - coeficientes(b, 1);
            else                
                valor = valor - (coeficientes(b, 1) * (x(1, a)^(b-1)));
            end                     
        end        
        resultados(1, a) = (y(1, a) + valor)^2;      
    end    
    sr = sum(resultados);
    
    syx = sqrt(sr/(i-(m+1)));
    
    %Coeficiente de determina��o
    r2 = (st-sr)/st;
    
    disp('Coeficientes das equa��es normais');
    disp(sistema);
    disp('Termos independentes das equa��es normais');
    disp(igualdade);
    disp('Os coeficientes do polin�mio s�o:');
    disp(coeficientes);
    
    disp('O desvio padr�o para este caso �:');
    disp(sy);
    disp('Erro-padr�o da estimativa para este caso foi:');
    disp(syx);
    disp('O coeficiente de determina��o para este caso foi:');
    disp(r2);
    porcentagem = r2*100;
    if sr == st && r2 == 0
        disp('O ajuste n�o apresentou nenhuma melhora');
    elseif sr ==0 && r2 == 1
        disp('Houve ajuste perfeito');
    elseif porcentagem >= 60
        disp('Neste caso houve melhora ao realizar o ajuste');        
        fprintf('Com a aplica��o deste m�todo de regress�o polinomial foi explicado %f % da incerteza em rela��o a amostra\n',porcentagem); 
    else
        disp('Neste caso n�o houve grande melhora ao realizar o ajuste');
        fprintf('Com a aplica��o deste m�todo de regress�o polinomial foi explicado %f % da incerteza em rela��o a amostra\n',porcentagem); 
    end

end