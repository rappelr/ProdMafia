package com.saladparty.io {

import com.company.assembleegameclient.util.TimeUtil;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

import kabam.lib.net.impl.Message;

    public class PacketPrinter {

        private const data:ByteArray = new ByteArray();

        public function PacketPrinter() {
            this.data.position = 0;
        }

        public function Print(msg:Message) {
            this.data.position = 0;
            this.data.length = 0;
            msg.writeToOutput(this.data);
            this.data.position = 0;

            var packetSize:int = this.data.bytesAvailable + 5;
            var path:String = "packet_log/" + TimeUtil.getUnixTime() + "_" + msg.id + "_" + packetSize + "b.bin";

            var file:File = File.applicationStorageDirectory.resolvePath(path);
            var fileStream:FileStream = new FileStream();

            fileStream.open(file, FileMode.WRITE);
            try {
                fileStream.writeInt(packetSize);
                fileStream.writeByte(msg.id);
                fileStream.writeBytes(this.data);
            }
            catch (e) {
                trace (e);
            }
            finally {
                fileStream.close();
            }
        }
    }
}
