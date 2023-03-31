-----Important
USE AdventureWorks2019
GO

CREATE PROCEDURE Purchasing.DeletePaymentsLT @IdPayment INT
AS
BEGIN

BEGIN TRY
BEGIN TRANSACTION          

DELETE Purchasing.paymentsLT 
		   	 OUTPUT deleted.IdPayment,
			        deleted.ProductID,			             
                    deleted.PayDate,
					deleted.PayAmount,
					NULL,
					NULL
             INTO Purchasing.logChangePaymentsLT 
WHERE IdPayment = @IdPayment

COMMIT TRANSACTION
END TRY

  BEGIN CATCH
     IF XACT_STATE() <> 0 ROLLBACK TRANSACTION
	 PRINT 'Unable to insert record'
	 ;THROW
	 RETURN -1
  END CATCH
  RETURN 0
END
