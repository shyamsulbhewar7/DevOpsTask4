 
 




FROM centos
RUN yum install sudo -y 
RUN yum install java -y 
RUN yum install git -y 
RUN yum install openssh-server -y 
RUN ssh-keygen -A 
RUN /usr/sbin/sshd -D &
CMD /bin/bash
CMD setenforce 0
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl 
RUN chmod +x ./kubectl 
RUN mkdir /root/.kube /root/jenkins 
RUN sudo mv ./kubectl /usr/local/bin/kubectl 
COPY ca.crt client.crt client.key config webserver.yaml /root/
RUN mv /root/config /root/.kube/config 
RUN yum install httpd -y 
RUN yum install php -y
COPY *.html /var/www/html/
CMD /usr/sbin/httpd -DFOREGROUND &
CMD /bin/bash
COPY ./index.html /var/www/html/
EXPOSE 80



