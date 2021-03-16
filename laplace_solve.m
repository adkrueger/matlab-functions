function sol_func = laplace_solve(func,init,matfunc)
%LAPLACE_SOLVE Solve n-order inital value problem
%   Inputs are:
%   func     :a symbolic function IVP with base symbolic function f(t)
%   init     :a numeric array of 1xN initial conditions of [x0;dx0;d2x;...]
%       if inputs are NaN function will include variable initial conditions
%   matfunc  :a logical return MATLAB function
% 
%   Outputs are:
%   sol_func :a function f(t) (returns MATLAB function if matfunc==true,
%       otherwise returns symbolic function)

    
    arguments
        func {mustBeA(func,'symfun')}
        init (:,1) {mustBeNumeric, mustBeReal}
        matfunc  {mustBeNumericOrLogical} = false
    end
    
    if isnan(init)
        initstr = strings(1,length(init));
        initstr(1) = "f_0";
        for i = 1:length(init)-1
            initstr(i+1) = sprintf("f__d__%d_0,",i);
        end
        init = str2sym(initstr);
    end
    
    syms f(t) F t s 
    lapeq = laplace(func,t,s);
    lapeq = subs(lapeq,laplace(f,t,s),F);
    lapeq = subs(lapeq,f(0),init(1));
    
    for i = 2:length(init)
        lapeq = subs(lapeq,subs(diff(f(t),t,i-1),t,0),init(i));
    end
    
    sol_lap = solve(lapeq,F);
    sol_func = ilaplace(sol_lap,s,t);
    
    if matfunc == true
        sol_func = matlabFunction(sol_func);
    end
end

