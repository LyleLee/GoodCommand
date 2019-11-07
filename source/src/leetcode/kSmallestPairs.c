#include <stdio.h>
#include <stdlib.h>
#include <string.h>



/**
 *  * Return an array of arrays of size *returnSize.
 *   * The sizes of the arrays are returned as *returnColumnSizes array.
 *    * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 *     */
struct sumAll{
	int u1;
	int u2;
	int sum;
};
int cpmSum(const void *a, const void *b)
{
	return ((struct sumAll *)a)->sum - ((struct sumAll *)b)->sum;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes){
	int i;
	int j;

	struct sumAll *sa = (struct sumAll *)malloc(sizeof(struct sumAll)*nums1Size*nums2Size);

	int m=0;
	for(i=0; i<nums1Size; i++)
	{
		for(j=0; j<nums2Size; j++)
		{
			sa[m].u1 = nums1[i];
			sa[m].u2 = nums2[j];
			sa[m].sum = nums1[i]+nums2[j];
			m++;
		}
	}
	qsort((void *)sa, nums1Size*nums2Size, sizeof(struct sumAll), cpmSum);

	int **re = (int **)malloc(sizeof(int *)*k);
	memset(re, 0 , sizeof(int *)*k);

	int n;
	for(n=0; n<k && n <m; n++)
	{
		re[n] = (int *)malloc(sizeof(int)*2);
		memset(re[n], 0, sizeof(int)*2);
		re[n][0] = sa[n].u1;
		re[n][1] = sa[n].u2;
	}
	int min = k<m?k:m;
	*returnSize = min;

	*returnColumnSizes = (int *)malloc(sizeof(int)*min);
	for(i=0; i<min; i++)
	{
		(*returnColumnSizes)[i] = 2;
	}


	free(sa);
	return re;

}

int main()
{
	int u1[]= {1,7,11};
	int u2[]= {2,4,6};
	int k =3;

	int returnSize;
	int p;
	int *p1 =&p;
	int **returnColumnSizes = &p1;
	int **re = kSmallestPairs(u1,3,u2,3,k, &returnSize,returnColumnSizes);
	
	int i;

	printf("returnSize:%d\n",returnSize);
	free(*returnColumnSizes);
	for(i=0; i<returnSize; i++)
		free(re[i]);
	free(re);

}
