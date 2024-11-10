## Change to custom user and finalize starting state.
ENV USER ${ID_NAME}
USER ${ID_NAME}

## Ensure that we're in our repo when we enter the docker
WORKDIR /home/${ID_NAME}

# Python path
ENV PYTHONPATH="/home/guest/dc_ws/src:$PYTHONPATH"

## Run a bash shell
CMD bash
