#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void printMatriz(int **A, int tam) {
    for (int i = 0; i < tam; i++) {
        for (int j = 0; j < tam; j++) {
            printf("%d ", A[i][j]);
        }
        printf("\n");
    } 
}

void printVetor(int *A, int tam) {
    for (int i = 0; i < tam; i++) {
        printf("%d ", A[i]);
        printf("\n");
    } 
}

int main(int argc, char *argv[]) {

    clock_t start, end;
    double time_taken;
    srand(time(NULL));

    FILE *arquivo;
    // arquivo = fopen("tempo_normal", "w");
     arquivo = fopen("tempo_trocado", "w");

    int N;
    int arrayN[10] = {1000, 5000, 10000, 15000, 20000, 25000, 30000, 35000, 40000, 50000};

    for(int n = 0; n < 10; n++){
        N = arrayN[n];

        int **A = (int**) calloc(N, sizeof(int*));
        int *X = (int*) calloc(N, sizeof(int));
        int *B = (int*) calloc(N, sizeof(int));
        for(int i=0; i<N; i++){
            A[i] = (int*) calloc(N, sizeof(int));
        }

        for(int i=0; i<N; i++){
            X[i] = rand()%10;
            for(int j=0; j<N; j++){
                A[i][j] = rand()%10;
            }
        }

        start = clock();
        
        // for (int i = 0; i < N; i++) {
        //     for (int j = 0; j < N; j++) {
        //         B[i] += A[i][j] * X[j];
        //     }
        // }

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                B[i] += A[j][i] * X[j];
            }
        }

        end = clock();

        time_taken = ((double) (end - start)) / CLOCKS_PER_SEC; // s

        // printf("A:");
        // printMatriz(A, N);
        // printf("X:");
        // printVetor(X, N);
        // printf("B:");
        // printVetor(B, N);

        for(int i=0; i<N; i++){
            free(A[i]);
        }
        free(A);
        free(B);
        free(X);

        printf("Tempo: %.5f s\n", time_taken);

        fprintf(arquivo,"%.5f\n", time_taken);
    }

    printf("Fim!\n");
    fclose(arquivo);

    return 0;
}
