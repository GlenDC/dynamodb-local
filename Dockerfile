FROM openjdk:7

ARG ddburl=http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz
ARG ddbloc=/root/dynamodb
ARG ddbtarball=dynamodb_local_latest.tar.gz

RUN curl -O -L ${ddburl}
RUN mkdir -p ${ddbloc} && tar -zxvf ${ddbtarball} -C ${ddbloc} && rm -f ${ddbtarball}

WORKDIR ${ddbloc}

RUN test -d /data || mkdir -p /data

EXPOSE 8000
ENTRYPOINT ["java", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", "DynamoDBLocal.jar", "-dbPath", "/data", "-port", "8000"]
