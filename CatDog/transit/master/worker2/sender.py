from paramiko import SSHClient, AutoAddPolicy
from scp import SCPClient
import os, glob, os.path
import time

class SSh(object):

    def __init__(self, address, username, password, port=22):
        print ("Connecting to server")
        self._address = address
        self._username = username
        self._password = password
        self._port = port
        self.sshObj = None
        self.connect()
        self.scp = SCPClient(self.sshObj.get_transport())

    def sendCommand(self, command):
        if(self.sshObj):
            stdin, stdout, stderr = self.sshObj.exec_command(command)
            while not stdout.channel.exit_status_ready():
                if stdout.channel.recv_ready():
                    alldata = stdout.channel.recv(1024)
                    prevdata = b"1"
                    while prevdata:
                        prevdata = stdout.channel.recv(1024)
                        alldata += prevdata

                    print(str(alldata))
        else:
            print ("Connection not opened")

    def connect(self):
        try:
            ssh = SSHClient()
            ssh.set_missing_host_key_policy(AutoAddPolicy())
            ssh.connect(self._address, port=self._port, username=self._username,password=self._password, timeout=20, look_for_keys=False)

            print ('Connected to {} over SSH'.format(self._address))
            return True
        except Exception as e:
            ssh = None
            print("Unable to connect to {} over SSH".format(self._address, e))
            return False
        finally:
            self.sshObj = ssh

def removeAllfile(filePath):
        fileList = glob.glob(os.path.join(filePath, "*.jpg"))
        for f in fileList:
            os.remove(f)
    

if __name__=="__main__":
    while(1):
        result = os.popen('ls -l /sender/result/ | grep ^- | wc -l').read()
        if result == '1':
            continue
        else:
            filepath = "/sender/result"
            ssh = SSh('IP', 'accountName', 'Password')
            ssh.scp.put(filepath, recursive=True, remote_path='/home/pi/result')
            time.sleep(5)
            removeAllfile(filepath)
            time.sleep(5)
