#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int country[150];
int ids[120];

pthread_t tid[120];

pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER;

void* see(void* arg)
{
        int index = *(int*)arg;
        while(1)
        {

                sleep(3);
                int current_country = rand()%150;
                pthread_rwlock_rdlock(&rwlock);
                printf("Person %d is checking for new cases...\n", index);
                printf("Person %d saw that the number of cases from country %d is %d\n", index, current_country, country[current_country]);
                pthread_rwlock_unlock(&rwlock);
        }
        return NULL;
}

void* update(void* arg)
{
        int index = *(int*)arg; //index of the thread
        while(1)
        {
                sleep(5);
                int current_country = rand()%150;
                int cases = rand()%15000;
                pthread_rwlock_wrlock(&rwlock);
                printf("Association %d has updated the number of cases of country %d -> %d new cases\n", index, current_country, cases);
                country[current_country] = cases;
                pthread_rwlock_unlock(&rwlock);
        }
        return NULL;
}

int main(int argc, char* argv[])
{
        int i;
        for (i=0; i<120; i++) ids[i] = i;
        for (i=0; i<100; i++)
                pthread_create(&tid[i], NULL, see, (void*)&ids[i]);
        for (i=100; i<120; i++)
                pthread_create(&tid[i], NULL, update, (void*)&ids[i]);
        for (i=0; i<120; i++)
                pthread_join(tid[i], NULL);
        pthread_rwlock_destroy(&rwlock);
        return 0;
}