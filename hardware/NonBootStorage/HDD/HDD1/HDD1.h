//The header file for the driver. This drive is not the boot drive.
#ifndef HDD1_H
#define HDD1_H

#include <cstdint> // For uint8_t, uint32_t etc.

// Define constants for HDD operations
#define SECTOR_SIZE 512

class HDD1Driver {
public:
    HDD1Driver(uint16_t basePort);
    ~HDD1Driver();

    bool initialize();
    bool readSector(uint32_t sectorNumber, uint8_t* buffer);
    bool writeSector(uint32_t sectorNumber, const uint8_t* buffer);

private:
    uint16_t m_basePort;
    // Add other internal state variables as needed
    // e.g., drive status, LBA mode enabled, etc.
};

#endif // HDD1_H