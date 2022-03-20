function RR_Ztest(alpha, type)
  
  switch type
    case -1
      l = -Inf
      r = norminv(alpha, 0, 1)
      fprintf('The rejection region RR is (%f, %f)\n', l, r)
    case 0
      r = norminv(1-alpha/2, 0, 1)
      l = -r
      fprintf('The rejection region RR is (%f, %f)U(%f, %f)\n', -Inf, l, r, Inf)
    case 1
      l = norminv(1-alpha, 0, 1)
      r = Inf
      fprintf('The rejection region RR is (%f, %f)\n', l, r)
  endswitch
  
endfunction

function RR_Ttest(alpha, n, type)
    switch type
      case -1
        l = -Inf
        r = tinv(alpha, n-1)
        fprintf('The rejection region RR is (%f, %f)\n', l, r)
      case 0
        r = tinv(1-alpha, n-1)
        l = -r
        fprintf('The rejection region RR is (%f, %f)U(%f, %f)\n', -Inf, l, r, Inf)
      case 1
        l = tinv(1-alpha, n-1)
        r = Inf
        fprintf('The rejection region RR is (%f, %f)\n', l, r)
    endswitch
endfunction

function RR_Ftest(alpha, n1, n2, type)
      switch type
        case -1
          l = -Inf
          r = finv(alpha, n1-1, n2-1)
          fprintf('The rejection region RR is (%f, %f)\n', l, r)
        case 0
          r = finv(1-alpha/2, n1-1, n2-1)
          l = -r
          fprintf('The rejection region RR is (%f, %f)U(%f, %f)\n', -Inf, l, r, Inf)
        case 1
          l = finv(1-alpha, n1-1, n2-1)
          r = Inf
          fprintf('The rejection region RR is (%f, %f)\n', l, r)
      endswitch
endfunction      
