1616 ./bin/runspec --test 失败


```
dist/threads/t/stress_re.......................................skipped
dist/threads/t/stress_string...................................skipped
dist/threads/t/thread..........................................skipped
dist/XSLoader/t/XSLoader.......................................ok
ext/autouse/t/autouse..........................................Goto undefined subroutine &Errno::EPERM at ../../lib/autouse.pm line 61.
# Looks like you planned 12 tests but ran 8.
# Looks like your test exited with 255 just after 8.
FAILED--expected 12 tests, saw 8
ext/B/t/b......................................................ok
ext/B/t/concise................................................ok
ext/B/t/concise-xs.............................................ok
ext/B/t/f_map..................................................ok
ext/B/t/f_sort.................................................ok
ext/B/t/optree_check...........................................ok
ext/B/t/optree_concise.........................................ok
ext/B/t/optree_constants.......................................ok
ext/B/t/optree_misc............................................ok
ext/B/t/optree_samples.........................................ok
ext/B/t/optree_sort............................................ok
ext/B/t/optree_specials........................................ok
ext/B/t/optree_varinit.........................................ok
ext/B/t/o......................................................ok
ext/B/t/pragma.................................................ok
ext/B/t/showlex................................................ok
ext/B/t/terse..................................................ok
ext/B/t/xref...................................................ok
ext/Devel-DProf/t/DProf........................................ok
ext/Devel-Peek/t/Peek..........................................ok
ext/Devel-SelfStubber/t/Devel-SelfStubber......................ok
ext/DynaLoader/t/DynaLoader....................................ok
ext/Errno/t/Errno..............................................FAILED--Further testing stopped: No errno's are exported
make: *** [test] Error 29
+ [ 2 -ne 0 ]
+ set +x


Hey!  Some of the Perl tests failed!  If you think this is okay, enter y now:

```