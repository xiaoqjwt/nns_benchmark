data_path=../../../data
query_path=../../../data
result_path=../results
mkdir ${result_path}

for data in "audio"
do
n=53387
m=200
K=20
PP=512
PI=64

dataset=${data_path}/${data}/${data}_base.txt
query=${data_path}/${data}/${data}_query.txt
result_path=${result_path}/${data}_NAPP_${PP}PP_${PI}PI.txt

Str="--queryTimeParams numPivotSearch=10  "
for i in 15 20 25 30 35 40 43 45 47 48 50 52 53 55 60
do
Str="${Str} -t numPivotSearch=$i "
done

../code/release/experiment \
--distType float --spaceType l2 \
--knn $K \
--dataFile ${dataset} --maxNumData $n --queryFile ${query} --maxNumQuery $m -o ${result_path} -a \
--method napp \
--createIndex numPivot=${PP},numPivotIndex=${PI},chunkIndexSize=1024,indexThreadQty=1 \
--saveIndex ../indices/${data}_${PP}PP_${PI}PI.napp \
${Str}


done
