/*
 * Atividade 2 - SSC0951 Desenvolvimento de Código Otimizado
 * Análise de performance com gprof
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*------------------------------------------------*/
/* Code to remove data from the processor caches. */
#define KB (1024)
#define MB (1024 * KB)
#define GB (1024 * MB)
#define LARGEST_CACHE_SZ (8 * MB)

static unsigned char dummy_buffer[LARGEST_CACHE_SZ];

void clean_cache()
{
    unsigned long long i;
    for (i = 0; i < LARGEST_CACHE_SZ; i++)
        dummy_buffer[i] += 1;
}

/*------------------------------------------------*/
/* Algoritmos de ordenação para análise com gprof */

// Bubble Sort - O(n²)
void bubble_sort(int arr[], int n) {
    int i, j, temp;
    for (i = 0; i < n-1; i++) {
        for (j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

// Selection Sort - O(n²)
void selection_sort(int arr[], int n) {
    int i, j, min_idx, temp;
    for (i = 0; i < n-1; i++) {
        min_idx = i;
        for (j = i+1; j < n; j++) {
            if (arr[j] < arr[min_idx])
                min_idx = j;
        }
        temp = arr[min_idx];
        arr[min_idx] = arr[i];
        arr[i] = temp;
    }
}

// Insertion Sort - O(n²)
void insertion_sort(int arr[], int n) {
    int i, key, j;
    for (i = 1; i < n; i++) {
        key = arr[i];
        j = i - 1;
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}

/*------------------------------------------------*/
/* Função auxiliar para copiar array */
void copy_array(int source[], int dest[], int n) {
    int i;
    for (i = 0; i < n; i++) {
        dest[i] = source[i];
    }
}

/*------------------------------------------------*/
/* Função auxiliar para gerar array aleatório */
void generate_random_array(int arr[], int n) {
    int i;
    srand(time(NULL));
    for (i = 0; i < n; i++) {
        arr[i] = rand() % 10000;
    }
}

/*------------------------------------------------*/
/* Função principal */
int main() {
    const int ARRAY_SIZE = 5000;  // Tamanho do array para teste
    const int NUM_EXECUTIONS = 10; // Número de execuções para cada algoritmo
    
    int *original_array = malloc(ARRAY_SIZE * sizeof(int));
    int *test_array = malloc(ARRAY_SIZE * sizeof(int));
    
    if (original_array == NULL || test_array == NULL) {
        printf("Erro ao alocar memória!\n");
        return 1;
    }

    // Gerar array aleatório
    generate_random_array(original_array, ARRAY_SIZE);
    
    // Teste do Bubble Sort
    for (int i = 0; i < NUM_EXECUTIONS; i++) {
        clean_cache();
        copy_array(original_array, test_array, ARRAY_SIZE);
        bubble_sort(test_array, ARRAY_SIZE);
    }
    
    // Teste do Selection Sort
    for (int i = 0; i < NUM_EXECUTIONS; i++) {
        clean_cache();
        copy_array(original_array, test_array, ARRAY_SIZE);
        selection_sort(test_array, ARRAY_SIZE);
    }
    
    // Teste do Insertion Sort
    for (int i = 0; i < NUM_EXECUTIONS; i++) {
        clean_cache();
        copy_array(original_array, test_array, ARRAY_SIZE);
        insertion_sort(test_array, ARRAY_SIZE);
    }
    
    free(original_array);
    free(test_array);
    
    return 0;
}
