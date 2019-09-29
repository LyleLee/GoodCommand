#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MIN(a,b) ((a>b)?b:a)

double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size){
	int s = nums1Size + nums2Size;
	int i=0, j1=0,j2=0;

	int *c = (int *)malloc(s*sizeof(int));
	memset(c, 0, s*sizeof(int));

	for(i=0 ; i<s; i++)
	{
		if( j1 == nums1Size)
		{
			c[i] = nums2[j2++];
		}
		else if (j2 == nums2Size)

		{
			c[i] = nums1[j1++];
		}
		else if(nums1[j1] <= nums2[j2])
		{
			c[i] = nums1[j1++];
		}
		else
		{
			c[i] = nums2[j2++];
		}
	}
	
	
	for(i=0; i<s; i++){ printf("%d ",i);   }printf("\n");
	for(i=0; i<s; i++){ printf("%d ",c[i]);}printf("\n");
	if( s%2 == 0)
	{
		return (c[s/2]+c[s/2-1])/2.0;
	}
	else
		return (c[s/2]);
}

int main()
{
	int a1[] = {1,3}, b1[] = {2};
	int a2[] = {1,2}, b2[] = {3,4};
	int a3[] = {1,2,3,4,5}, b3[] = {6,7,8,9,10};
	int a4[] = {2,2,2,3,3,10}, b4[] = {1,2,6,9};
	printf("median:%lf\n",findMedianSortedArrays(a1, 2, b1, 1));
	printf("median:%lf\n",findMedianSortedArrays(a2, 2, b2, 2));
	printf("median:%lf\n",findMedianSortedArrays(a3, 5, b3, 5));
	printf("median:%lf\n",findMedianSortedArrays(a4, 6, b4, 4));
}
