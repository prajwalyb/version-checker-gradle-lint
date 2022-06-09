FROM openjdk:11





# Set Environment Variables
ENV SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip" \
    ANDROID_HOME="/usr/local/android-sdk" \
    ANDROID_VERSION=29 \
    ANDROID_WITH_CMD = "/usr/local/android-sdk/cmdline-tools"

# Download Android SDK
RUN mkdir "$ANDROID_HOME" .android \
    && chmod 666 "$ANDROID_HOME" \
    && cd "$ANDROID_HOME" \
    && mkdir "cmdline-tools" \
    && cd "cmdline-tools"
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && mkdir "$ANDROID_HOME/licenses" || true \
    && echo "f1cdd6f4629b5254fef44ce0e7b6a96cde9dbd49" > "$ANDROID_HOME/licenses/android-sdk-license" \
    && mkdir "tools" \
    && cp -r "cmdline-tools" "tools" \
    && rm -rf "cmdline-tools" \
    
    
    && yes | $ANDROID_WITH_CMD/tools/bin/sdkmanager --licenses

# Install Android Build Tool and Libraries
RUN $ANDROID_WITH_CMD/tools/bin/sdkmanager --update
RUN $ANDROID_WITH_CMD/tools/bin/sdkmanager "build-tools;29.0.2"
RUN $ANDROID_WITH_CMD/tools/bin/sdkmanager "platforms;android-${ANDROID_VERSION}" 
RUN $ANDROID_WITH_CMD/tools/bin/sdkmanager "platform-tools"

CMD ["/bin/bash"]
