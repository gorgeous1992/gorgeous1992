function F = dispersionRelation(k, g, sigma, h)
    F = dispFunction(k);
    function F = dispFunction(k)
        F = sigma.^2 - g*k.*tanh(h.*k);
    end
end
