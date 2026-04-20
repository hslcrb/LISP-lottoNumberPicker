#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void generate_set() {
    int nums[6];
    int count = 0;
    while (count < 6) {
        int r = (rand() % 45) + 1;
        int duplicate = 0;
        for (int i = 0; i < count; i++) {
            if (nums[i] == r) {
                duplicate = 1;
                break;
            }
        }
        if (!duplicate) {
            nums[count++] = r;
        }
    }
    
    // Sort
    for (int i = 0; i < 5; i++) {
        for (int j = i + 1; j < 6; j++) {
            if (nums[i] > nums[j]) {
                int temp = nums[i];
                nums[i] = nums[j];
                nums[j] = temp;
            }
        }
    }

    for (int i = 0; i < 6; i++) {
        printf("%d%c", nums[i], (i == 5 ? '\n' : ' '));
    }
}

int main(int argc, char *argv[]) {
    int count = 1;
    if (argc > 1) {
        count = atoi(argv[1]);
    }

    srand(time(NULL));

    for (int i = 0; i < count; i++) {
        generate_set();
    }

    return 0;
}
