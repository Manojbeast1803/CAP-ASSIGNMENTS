using { com.epm as db } from '../db/schema';

service ReportService {

    @readonly
    entity ProductCatalog as projection on db.ProductCatalog;

    @readonly
    entity OrderReport as projection on db.OrderReport;

    @readonly
    entity LowStockAlert as projection on db.LowStockAlert;

}