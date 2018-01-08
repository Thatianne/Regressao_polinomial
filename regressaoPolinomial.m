function regressaoPolinomial(x, y, m)

    [i, j] = size(x);    
    novoY = [y, sumx(y)/i];
    somatoriosX = zeros( m+2, 1);
    somatoriosX(1, 1) = sum(x);
    somatoriosXY = zeros(m+1, 1);
    somatoriosXY(1, 1) = sum(y);
    xExp = zeros(i, m + 1);
    xyExp = zeros(i, m);
    cc = zeros(i + 1, 1);
    
    for a=1:m+1
        for b=1:i
            xExp(b, a) = x(b, 1)^(a+1);
            
            if a <= m
                xyExp(b, a) = (x(b, 1)^a) * y(b, 1);
            end
           
            if a < 2
                cc(b, 1) = (y(b, 1) - novoY(i+1, 1))^2;
            end
        end
        
        somatoriosX(a+1, 1) = sum(xExp(1:b, a:a));        
        
        if a <= m
            somatoriosXY( a+1, 1) = sum(xyExp(1:b, a:a));            
        end
        
        if a < 2
            cc(i+1, 1) = sum(cc);
        end
    end
    
    sistema = ones(m+1, m+1);
    igualdade = ones(m+1, 1);        
    
    for a=1:m+1
        for b=1:m+1
            if a == 1 && b == 1
                sistema(a, b) = i;
            end
            
        end
    end
            
    
end