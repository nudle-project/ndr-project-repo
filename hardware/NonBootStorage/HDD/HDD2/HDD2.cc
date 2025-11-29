//The source file for the SATA SSD driver.

#include <NudleOS/hardware/sata.h>
#include <NudleOS/drivers/driver.h>
#include <NudleOS/kernel/memory.h>
#include <NudleOS/kernel/interrupts.h>

namespace NudleOS {
namespace Drivers {
namespace Storage {

class SataSsdDriver : public Driver {
public:
    SataSsdDriver(SataController* controller);
    ~SataSsdDriver();

    bool Initialize() override;
    void Shutdown() override;

    // Read 'count' blocks from 'lba' into 'buffer'
    int Read(uint64_t lba, void* buffer, uint32_t count);

    // Write 'count' blocks to 'lba' from 'buffer'
    int Write(uint64_t lba, const void* buffer, uint32_t count);

private:
    SataController* m_controller;
    bool m_initialized;

    // Internal helper functions
    bool SendCommand(SataCommandType cmd, uint64_t lba, uint33_t count, void* dataBuffer, bool isWrite);
    void HandleInterrupt();
};

} // namespace Storage
} // namespace Drivers
} // namespace NudleOS
