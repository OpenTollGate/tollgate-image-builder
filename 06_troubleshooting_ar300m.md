From the details you've provided, it seems the issue might be related to the image size constraints or a potential conflict with the `tollgate-module-whoami-go`. Here are a few steps to help troubleshoot and potentially resolve the issue:

### Troubleshooting Steps

1. **Check Image Size Constraints:**
 - Verify the available space on the device. The error suggests the sysupgrade image isn't being created, possibly due to exceeding space limits.
   - Compare the size of the built images with and without the `tollgate-module-whoami-go`. You mentioned it working on a more performant router, which likely has more storage.

2. **Review Dependencies:**
   - Ensure `tollgate-module-whoami-go` and its dependencies do not introduce conflicts or require additional space beyond what's available.
   - Look for additional dependencies required by this module that might increase the image size significantly.

3. **Verbose Output:**
   - Run the script with verbose output to catch detailed errors. Add `set -x` at the top of your build script if not already present.
   - Carefully examine any messages or warnings that might hint at the cause of the issue.

4. **Check for Warnings or Errors in Logs:**
   - Review the build logs for warnings or errors related to package conflicts or build process interruptions.

5. **Experiment with a Smaller Module:**
   - Test building with a smaller or simpler version of the `tollgate-module-whoami-go` to determine if the issue is size-related.
   - If it works, gradually add features/components back until you identify the threshold causing the error.

### Actions for Resolution

1. **Remove Unnecessary Packages:**
   - Consider removing non-essential packages from the image to free up space. For instance, verify if all packages listed under `BASE_PACKAGES` and `EXTRA_PACKAGES` are necessary.

2. **Increase Partition Size:**
   - If possible, adjust the partition size for the firmware. Refer to device-specific OpenWrt documentation for guidance.

3. **Optimize Module:**
   - Optimize the `tollgate-module-whoami-go` for reduced size, potentially by stripping unnecessary functionality or optimizing code and dependencies.

4. **Configure Build Options:**
   Use OpenWrt ImageBuilder configurations to enable or disable certain functionalities that might reduce the binary size.

5. **Consider Compression Settings:**
   - Review and potentially modify compression settings for the SquashFS to optimize for smaller image sizes.

By addressing these aspects, you can pinpoint whether the issue is related to image size or potentially something else like a dependency conflict. This systematic approach helps in managing OpenWrt images on devices with strict storage constraints.