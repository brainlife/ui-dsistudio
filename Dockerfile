FROM dsistudio/dsistudio

EXPOSE 5900

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y vim mesa-utils tightvncserver xfce4 wmctrl unzip
#RUN apt-get remove -y xfce4-panel

ADD virtualgl_2.6_amd64.deb /
RUN dpkg -i /virtualgl_2.6_amd64.deb

# Copy VNC script that handles restarts
ADD startvnc.sh /
ADD xstartup /root/.vnc/xstartup
ENV USER=root X11VNC_PASSWORD=override

ADD xfce4 /root/.config/xfce4

CMD ["/startvnc.sh"]

