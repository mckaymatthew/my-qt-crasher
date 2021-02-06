# Variables
CRASHPAD_DIR="/Users/bobby/Desktop/bugsplat/crashpad/crashpad"
PROJECT_DIR="/Users/bobby/Documents/Qt/myQtCrasher"

# Start in the Crashpad dir
cd $CRASHPAD_DIR

# Update Crashpad
git pull -r
gclient sync

# Build Crashpad
ninja -C ./out/mac_universal

# Copy .h Includess
rsync -avh --include='*/' --include='*.h' --exclude='*' --prune-empty-dirs ./ $PROJECT_DIR/Crashpad/Include/crashpad 

# Copy Libraries
cp ./out/mac_universal/obj/client/libclient.a $PROJECT_DIR/Crashpad/Libraries/MacOS 
cp ./out/mac_universal/obj/util/libutil.a $PROJECT_DIR/Crashpad/Libraries/MacOS
cp ./out/mac_universal/obj/third_party/mini_chromium/mini_chromium/base/libbase.a $PROJECT_DIR/Crashpad/Libraries/MacOS
cp ./out/mac_universal/obj/out/mac-universal/gen/util/mach/* $PROJECT_DIR/Crashpad/Libraries/MacOS/util/mach  

# Copy Handler
cp ./out/mac_universal/crashpad_handler ~/Documents/qt/myQtCrasher/Crashpad/Bin/MacOS
