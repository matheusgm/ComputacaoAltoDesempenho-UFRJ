module procedures
    implicit none
  
  contains
  
    subroutine print_matrix(A, N)
        implicit none
        integer, dimension(:,:), intent(in) :: A
        integer, intent(in) :: N
        integer :: i, j
        do i = 1, N
            do j = 1, N
                write(*, "(I3)", advance="no") A(i,j)
            end do
            print *
        end do
    end subroutine print_matrix


    subroutine print_vector(A, N)
        implicit none
        integer, dimension(:), intent(in) :: A
        integer, intent(in) :: N
        integer :: i
        do i = 1, N
            write(*, "(I3)") A(i)
        end do
    end subroutine print_vector
end module


program matrix_vector_multiplication
    use procedures
    implicit none
    integer, dimension(:,:), allocatable :: A
    integer, dimension(:), allocatable :: X, B
    integer :: N, i, j, start, end, rate
    real :: time_taken
    real :: random_n

    integer :: nn, arrayN(10)
    character(len=30) :: filename = "tempo_normal_fortran"
    ! character(len=30) :: filename = "tempo_trocado_fortran"
    integer :: ierr, unit

    call srand(1000)

    arrayN = [1000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 50000]
    unit = 10
    open(unit, file=filename, action='write')
    if (ierr /= 0) then
        print *, "Erro ao abrir o arquivo"
        stop
    end if

    do nn = 1, 10
        N = arrayN(nn)
        allocate(A(N,N), X(N), B(N))

        do i = 1, N
            call random_number(random_n)
            X(i) = int(random_n * 10)
            do j = 1, N
                call random_number(random_n)
                A(i,j) = int(random_n * 10)
            end do
        end do

        call system_clock(start, rate)

        do i = 1, N
            do j = 1, N
                B(i) = B(i) + A(i,j) * X(j)
            end do
        end do

        ! do i = 1, N
        !     do j = 1, N
        !         B(i) = B(i) + A(j,i) * X(j)
        !     end do
        ! end do

        call system_clock(end, rate)

        time_taken = real(end-start)/real(rate)

        ! print *, "A:"
        ! call print_matrix(A, N)
        ! print *, "X:"
        ! call print_vector(X, N)
        ! print *, "B:"
        ! call print_vector(B, N)
        print *, "Tempo: ", time_taken, "s"
        write(unit, "(F0.3)") time_taken
    
        deallocate(A, X, B)
    end do

    close(unit)
    print *, "Fim!"

    stop
end program matrix_vector_multiplication


