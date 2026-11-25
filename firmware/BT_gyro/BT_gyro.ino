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
 uint8_t buf_comp_data[18];
  
  read(I2C_SLAVE_REG_C_ACC_X_LOW, buf_comp_data, 18);
  
  int16_t acc_c_x = (buf_comp_data[1]<<8) | buf_comp_data[0];
  int16_t acc_c_y = (buf_comp_data[3]<<8) | buf_comp_data[2];
  int16_t acc_c_z = (buf_comp_data[5]<<8) | buf_comp_data[4];
  int16_t gyro_c_x = (buf_comp_data[7]<<8) | buf_comp_data[6];
  int16_t gyro_c_y = (buf_comp_data[9]<<8) | buf_comp_data[8];
  int16_t gyro_c_z = (buf_comp_data[11]<<8) | buf_comp_data[10];

  
  float comp_acc_x = (float)acc_c_x * 16.0 / 32767;
  float comp_acc_y = (float)acc_c_y * 16.0 / 32767;
  float comp_acc_z = (float)acc_c_z * 16.0 / 32767;
  float comp_gyro_x = (float)gyro_c_x * 2000 / 32767;
  float comp_gyro_y = (float)gyro_c_y * 2000 / 32767;
  float comp_gyro_z = (float)gyro_c_z * 2000 / 32767;



    int reading0 = analogRead(analogPin0);
   
  float Voltage0 = float(abs(reading0-365)+350);

  int reading1 = analogRead(analogPin1);

  float Voltage1 = float(abs(reading1-365)+350);

   int reading2 = analogRead(analogPin2);

  float Voltage2 = float(abs(reading2-365)+350);

  int reading3 = analogRead(analogPin3);

  float Voltage3 = float(abs(reading3-365)+350);

  int reading4 = analogRead(analogPin4);

  float Voltage4 = float(abs(reading4-365)+350);

  int reading5 = analogRead(analogPin5);

  float Voltage5 = float(abs(reading5-365)+350);


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
  BTSerial.print(comp_acc_x); 
  BTSerial.print(" , "); 
  BTSerial.print(comp_acc_y); 
  BTSerial.print(" , "); 
  BTSerial.print(comp_acc_z); 
  BTSerial.print(" , "); 
  BTSerial.print(comp_gyro_x); 
  BTSerial.print(" , "); 
  BTSerial.print(comp_gyro_y); 
  BTSerial.print(" , "); 
  BTSerial.println(comp_gyro_z); 



  delay(5);
}
