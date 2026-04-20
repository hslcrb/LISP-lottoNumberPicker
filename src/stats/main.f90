program lotto_stats
    implicit none
    integer :: num, i, total_nums, status
    integer, dimension(1:45) :: freq
    real :: mean, sum_val
    integer, dimension(6) :: row

    freq = 0
    total_nums = 0
    sum_val = 0.0

    do
        read(*, *, iostat=status) row
        if (status /= 0) exit
        do i = 1, 6
            num = row(i)
            if (num >= 1 .and. num <= 45) then
                freq(num) = freq(num) + 1
                sum_val = sum_val + num
                total_nums = total_nums + 1
            end if
        end do
    end do

    print *, "--- FORTRAN Statistical Analysis ---"
    if (total_nums > 0) then
        mean = sum_val / total_nums
        print '(A, F6.2)', " Average number value: ", mean
        print *, " Frequencies (Number: Count):"
        do i = 1, 45
            if (freq(i) > 0) then
                print '(A, I2, A, I4)', "  [", i, "] : ", freq(i)
            end if
        end do
    else
        print *, "No data provided."
    end if
end program lotto_stats
