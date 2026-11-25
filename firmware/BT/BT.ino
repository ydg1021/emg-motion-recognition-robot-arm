#include <SoftwareSerial.h>
#include <Wire.h>
 
SoftwareSerial BTSerial(5,6);
#define MYAHRS_I2C_ADDRESS           0x20
#define MYMOTION_WHO_AM_I_VALUE      0xB1

//EMG1번
int analogPin0 = A0;
int analogPin1 = A1;
//EMG2번
int analogPin2 = A2;
int analogPin3 = A3;
//EMG3번
int analogPin4 = A4;
int analogPin5 = A5;

enum {
    I2C_SLAVE_REG_WHO_AM_I = 0x01,
    I2C_SLAVE_REG_REV_ID_MAJOR,
    I2C_SLAVE_REG_REV_ID_MINOR,
    I2C_SLAVE_REG_STATUS,

    // RAW DATA
    I2C_SLAVE_REG_I_ACC_X_LOW = 0x10,
    I2C_SLAVE_REG_I_ACC_X_HIGH,
    I2C_SLAVE_REG_I_ACC_Y_LOW,
    I2C_SLAVE_REG_I_ACC_Y_HIGH,
    I2C_SLAVE_REG_I_ACC_Z_LOW,
    I2C_SLAVE_REG_I_ACC_Z_HIGH,
    I2C_SLAVE_REG_I_GYRO_X_LOW,
    I2C_SLAVE_REG_I_GYRO_X_HIGH,
    I2C_SLAVE_REG_I_GYRO_Y_LOW,
    I2C_SLAVE_REG_I_GYRO_Y_HIGH,
    I2C_SLAVE_REG_I_GYRO_Z_LOW,
    I2C_SLAVE_REG_I_GYRO_Z_HIGH,
    I2C_SLAVE_REG_I_MAGNET_X_LOW,
    I2C_SLAVE_REG_I_MAGNET_X_HIGH,
    I2C_SLAVE_REG_I_MAGNET_Y_LOW,
    I2C_SLAVE_REG_I_MAGNET_Y_HIGH,
    I2C_SLAVE_REG_I_MAGNET_Z_LOW,
    I2C_SLAVE_REG_I_MAGNET_Z_HIGH,

    // COMPENSATED DATA
    I2C_SLAVE_REG_C_ACC_X_LOW,
    I2C_SLAVE_REG_C_ACC_X_HIGH,
    I2C_SLAVE_REG_C_ACC_Y_LOW,
    I2C_SLAVE_REG_C_ACC_Y_HIGH,
    I2C_SLAVE_REG_C_ACC_Z_LOW,
    I2C_SLAVE_REG_C_ACC_Z_HIGH,
    I2C_SLAVE_REG_C_GYRO_X_LOW,
    I2C_SLAVE_REG_C_GYRO_X_HIGH,
    I2C_SLAVE_REG_C_GYRO_Y_LOW,
    I2C_SLAVE_REG_C_GYRO_Y_HIGH,
    I2C_SLAVE_REG_C_GYRO_Z_LOW,
    I2C_SLAVE_REG_C_GYRO_Z_HIGH,
    I2C_SLAVE_REG_C_MAGNET_X_LOW,
    I2C_SLAVE_REG_C_MAGNET_X_HIGH,
    I2C_SLAVE_REG_C_MAGNET_Y_LOW,
    I2C_SLAVE_REG_C_MAGNET_Y_HIGH,
    I2C_SLAVE_REG_C_MAGNET_Z_LOW,
    I2C_SLAVE_REG_C_MAGNET_Z_HIGH,
    I2C_SLAVE_REG_C_TEMPERATURE_LOW,
    I2C_SLAVE_REG_C_TEMPERATURE_HIGH,

    // Attitude - Euler angle
    I2C_SLAVE_REG_ROLL_LOW,
    I2C_SLAVE_REG_ROLL_HIGH,
    I2C_SLAVE_REG_PITCH_LOW,
    I2C_SLAVE_REG_PITCH_HIGH,
    I2C_SLAVE_REG_YAW_LOW,
    I2C_SLAVE_REG_YAW_HIGH,
    
    //Attitude - Quaternion
    I2C_SLAVE_REG_QUATERNIAN_X_LOW,
    I2C_SLAVE_REG_QUATERNIAN_X_HIGH,
    I2C_SLAVE_REG_QUATERNIAN_Y_LOW,
    I2C_SLAVE_REG_QUATERNIAN_Y_HIGH,
    I2C_SLAVE_REG_QUATERNIAN_Z_LOW,
    I2C_SLAVE_REG_QUATERNIAN_Z_HIGH,
    I2C_SLAVE_REG_QUATERNIAN_W_LOW,
    I2C_SLAVE_REG_QUATERNIAN_W_HIGH,
};

void setup()
{
  Serial.begin(57600); //컴퓨터와의 통신속도 설정
  BTSerial.begin(57600);//블루투스와의 통신속도 설정
  Wire.begin();

}

bool sensor_init()
{
  uint8_t buf_whomi[1];
  uint8_t buf_stat[1];
    
  if(read(I2C_SLAVE_REG_WHO_AM_I, buf_whomi, 1) != 0xB1) {
    return false;
  }
  if(read(I2C_SLAVE_REG_STATUS, buf_stat, 1) != 0x80) {
    return false;
  }
  return true;
}

// i2C 관련. sdk 포함되어있던 코드. 건드리지말것
bool read(uint8_t reg_add, uint8_t* buff , uint8_t len)
{
    Wire.beginTransmission((uint8_t)MYAHRS_I2C_ADDRESS);  
        
    Wire.write(reg_add); 
    
    Wire.endTransmission(false); 

    Wire.requestFrom((uint8_t)MYAHRS_I2C_ADDRESS, len);

    uint8_t cnt = 0;
    while(Wire.available()) {
        buff[cnt++] = Wire.read();
    }

    return (cnt == len);
}
// i2C 관련. sdk 포함되어있던 코드. 건드리지말것
bool write(uint8_t reg_add, uint8_t* buff , uint8_t len)
{
    Wire.beginTransmission((uint8_t)MYAHRS_I2C_ADDRESS);
    
    Wire.write(reg_add);                          

    for(uint8_t cnt=0; cnt<len; cnt++) {
        Wire.write(buff[cnt]);                   
    }
    
    return Wire.endTransmission(true) == 0;   
}


void loop()
{
  uint8_t buf_quat[8];
  
  read(I2C_SLAVE_REG_QUATERNIAN_X_LOW, buf_quat, 8);
  
  int16_t quat_x = (buf_quat[1]<<8) | buf_quat[0];
  int16_t quat_y = (buf_quat[3]<<8) | buf_quat[2];
  int16_t quat_z = (buf_quat[5]<<8) | buf_quat[4];
  int16_t quat_w = (buf_quat[7]<<8) | buf_quat[6];
  
  float quaternion_x = (float)quat_x / 32767;
  float quaternion_y = (float)quat_y / 32767;
  float quaternion_z = (float)quat_z / 32767;
  float quaternion_w = (float)quat_w / 32767;

    int reading0 = analogRead(analogPin0);
  float Voltage0 = float(reading0)*5/1023;

  int reading1 = analogRead(analogPin1);
  float Voltage1 = float(reading1)*5/1023;

   int reading2 = analogRead(analogPin2);
  float Voltage2 = float(reading2)*5/1023;

  int reading3 = analogRead(analogPin3);
  float Voltage3 = float(reading3)*5/1023;

  int reading4 = analogRead(analogPin4);
  float Voltage4 = float(reading4)*5/1023;

  int reading5 = analogRead(analogPin5);
  float Voltage5 = float(reading5)*5/1023;

  BTSerial.print(Voltage0,4);
  BTSerial.print(",");
  BTSerial.print(Voltage1,4);
  BTSerial.print(",");
  BTSerial.print(Voltage2,4);
  BTSerial.print(",");
  BTSerial.print(Voltage3,4);
  BTSerial.print(",");
  BTSerial.print(Voltage4,4);
  BTSerial.print(",");
  BTSerial.print(Voltage5,4);
  BTSerial.print(",");
  BTSerial.print(quaternion_x); 
  BTSerial.print(" , "); 
  BTSerial.print(quaternion_y); 
  BTSerial.print(" , "); 
  BTSerial.print(quaternion_z); 
  BTSerial.print(" , "); 
  BTSerial.println(quaternion_w);

  delay(5);
}
