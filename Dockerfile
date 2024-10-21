# Використовуємо офіційний образ Jenkins LTS (довгострокова підтримка)
FROM jenkins/jenkins:lts

# Виконуємо дії від імені root користувача
USER root

# Оновлюємо список пакетів і встановлюємо необхідні для Ubuntu інструменти
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    maven \
    openjdk-11-jdk

# Додаємо користувача Jenkins до sudoers, щоб він мав привілеї суперкористувача без запиту пароля
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Повертаємось до користувача Jenkins
USER jenkins

# Експонуємо порт Jenkins (стандартний порт 8080)
EXPOSE 8080

# Стартова команда Jenkins
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
