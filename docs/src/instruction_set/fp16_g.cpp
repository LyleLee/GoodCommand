#include <vector>
#include <algorithm>

#include <arm_neon.h>

float16_t my_rand() {
  return float16_t( double(rand()) / double(RAND_MAX) );
}

int main(void) {
  srand( 11 );
  int sz = 800;

  std::vector<float16_t> flt1(sz);
  std::vector<float16_t> flt2(sz);
  std::vector<float16_t> flt3(sz);
  std::generate( flt1.begin() , flt1.end() , my_rand );
  std::generate( flt2.begin() , flt2.end() , my_rand );

  for ( size_t i = 0 ; i < sz ; i += 8 ) {
    float16x8_t f1 = vld1q_f16( &(flt1[i]) );
    float16x8_t f2 = vld1q_f16( &(flt2[i]) );
    float16x8_t f3 = vmulq_f16( f1 , f2 );
    vst1q_f16( &(flt3[i]) , f3 );
  }

  return 0;
}
