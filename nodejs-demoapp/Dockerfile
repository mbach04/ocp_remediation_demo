FROM quay.io/mbach/ubi7:7.7-99
#FROM registry.redhat.io/ubi7/ubi:7.7-358

EXPOSE 8080

ENV APP_ROOT=/opt/app-root


RUN INSTALL_PKGS="gcc-c++ \
  make \
  git" && \
  yum install -y $INSTALL_PKGS && \
  curl -sL https://rpm.nodesource.com/setup_12.x | bash - && \
  yum install -y nodejs && \
  yum -y clean all && \
  git clone https://github.com/mbach04/nodejs-demoapp.git ${APP_ROOT} && \
  mv ${APP_ROOT}/src/* ${APP_ROOT} && \
  # Drop the root user and make the content of /opt/app-root owned by user 1001
  chown -R 1001:0 ${APP_ROOT} && chmod -R ug+rwx ${APP_ROOT} && \
  cd ${APP_ROOT} && \
  ls && \
  npm i --production && \
  npm fund && \
  npm audit fix && \
  npm install debug 

CMD ["npm", "start", "--prefix", "/opt/app-root/"]


