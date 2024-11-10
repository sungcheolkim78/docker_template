## Change to custom user and finalize starting state.
ENV USER ${ID_NAME}
USER ${ID_NAME}
WORKDIR /home/${ID_NAME}/dc_ws

# install ohmyzsh for zsh setup
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

USER root
COPY ./docker/${ID_NAME}.zshrc /home/${ID_NAME}/.zshrc
RUN chown ${ID_NAME}:${ID_NAME} /home/${ID_NAME}/.zshrc
RUN chsh -s /usr/bin/zsh ${ID_NAME}
RUN service ssh start

# Last command for SSH daemon mode
CMD ["/usr/sbin/sshd", "-D"]

