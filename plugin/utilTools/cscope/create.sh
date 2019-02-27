

# example as fallows.

find ~/project/qd_server/comm_proj -name "*.h" -o -name "*.cpp" > comm.cs
# find ~/project/qd_server/txplus-3.0.0 -name "*.h" -o -name "*.cpp" > tx300.cs
find ~/project/qd_server/tx_plus_proj -name "*.h" -o -name "*.cpp" > txtrunk.cs
find ~/spp/code/SPP_proj/trunk/src -name "*.h" -o -name "*.cpp" > spp.cs

cat comm.cs > cscope.cs
# cat tx300.cs >> cscope.cs
cat txtrunk.cs >> cscope.cs
cat spp.cs >> cscope.cs

cscope -bkq -i cscope.cs
