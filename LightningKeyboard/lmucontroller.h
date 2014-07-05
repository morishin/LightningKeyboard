//
//  lmucontroller.h
//  LightningKeyboard
//
//  Copyright (c) 2014 Shintaro Morikawa. All rights reserved.
//

enum {
    kGetSensorReadingID = 0,
    kGetLEDBrightnessID = 1,
    kSetLEDBrightnessID = 2,
    kSetLEDFadeID       = 3,

    // other firmware-related functions
    // verifyFirmwareID     = 4,  // verifyFirmware(int *)
    // getFirmwareVersionID = 5,  // getFirmwareVersion(int *)

    // other flashing-related functions
    // ...
};

static io_connect_t dataPort = 0;

io_connect_t getDataPort(void) {
    kern_return_t     kr;
    io_service_t      serviceObject;
    
    if (dataPort) return dataPort;
    
    // Look up a registered IOService object whose class is AppleLMUController
    serviceObject = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleLMUController"));
    
    if (!serviceObject) {
        printf("getLightSensors() error: failed to find ambient light sensor\n");
        return 0;
    }
    
    // Create a connection to the IOService object
    kr = IOServiceOpen(serviceObject, mach_task_self(), 0, &dataPort);
    IOObjectRelease(serviceObject);
    
    if (kr != KERN_SUCCESS) {
        printf("getLightSensors() error: failed to open IoService object\n");
        return 0;
    }
    
    return dataPort;
}

void setKeyboardBrightness(float in) {
    // static io_connect_t dp = 0; // shared?
    kern_return_t kr;
    
    uint32_t inputCount  = 2;
    uint64_t inputValues[2];
    uint64_t in_unknown = 0;
    uint64_t in_brightness = in * 0xfff;
    
    inputValues[0] = in_unknown;
    inputValues[1] = in_brightness;
    
    uint32_t outputCount = 1;
    uint64_t outputValues[1];
    
    uint64_t out_brightness;
    
    //kr = IOConnectMethodScalarIScalarO(dp, kSetLEDBrightnessID,
    kr = IOConnectCallScalarMethod(getDataPort(),
                                   kSetLEDBrightnessID,
                                   inputValues,
                                   inputCount,
                                   outputValues,
                                   &outputCount);
    
    out_brightness = outputValues[0];
    
    if (kr != KERN_SUCCESS) {
        printf("setKeyboardBrightness() error\n");
        return;
    }
}
