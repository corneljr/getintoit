class Array

  def mean
    sum == 0 || size == 0 ? 0 : (sum.to_f / size.to_f)
  end

  def median
    sorted = sort()
    if (sorted.size.modulo(2) == 0) then
      ((sorted[(sorted.size / 2) - 1] + sorted[(sorted.size / 2)]) / 2.0)
    else
      sorted[sorted.size / 2]
    end
  end

end
