FROM openjdk:11



# Install Build Essentials
RUN yum update \
    && yum install build-essential -y

# Set Environment Variables
ENV SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip" \
    ANDROID_HOME="/usr/local/android-sdk/cmdline-tools" \
    ANDROID_VERSION=29

# Download Android SDK
RUN mkdir "$ANDROID_HOME" .android \
    && chmod 666 "/usr/local/android-sdk" \
    && cd "$ANDROID_HOME" \
    && curl -o sdk.zip $SDK_URL \
    && unzip sdk.zip \
    && rm sdk.zip \
    && mkdir "$ANDROID_HOME/licenses" || true \
    && echo "f1cdd6f4629b5254fef44ce0e7b6a96cde9dbd49" > "$ANDROID_HOME/licenses/android-sdk-license" \
    && mkdir "tools" \
    && cp -r "cmdline-tools" "tools" \
    && rm -rf "cmdline-tools" \
    
    
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

# Install Android Build Tool and Libraries
RUN $ANDROID_HOME/tools/bin/sdkmanager --update
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;29.0.2" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools"

CMD ["/bin/bash"]
